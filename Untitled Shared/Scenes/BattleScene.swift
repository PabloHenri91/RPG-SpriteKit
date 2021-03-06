//
//  BattleScene.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit
import GameplayKit

class BattleScene: GameScene, MapManagerDelegate {
    
    weak var gameWorld: GameWorld!
    weak var gameCamera: GameCamera!
    weak var player: PlayerCharacter!
    weak var statusBar: StatusBar!
    weak var playerHUD: PlayerHUD!
    
    var mapManager: MapManager!
    
    enum state: String {
        
        case loading
        
        case battle
        
        case battleEnd
        case battleEndInterval
        case showBattleResult
        
        case mainMenu
        case credits
    }
    
    var state: state = .loading
    var nextState: state = .loading
    
    var battleEndTime: Double = 0
    var battleBeginTime: Double = 0
    var maxBattleDuration: Double = 60 * 3
    
    enum zPositionType: CGFloat {
        case player = 1000
    }
    
    override func load() {
        super.load()
        
        self.loadGameWorld()
        self.loadPlayer(gameWorld: self.gameWorld)
        self.loadMapManager(player: self.player)
        self.loadGameCamera(gameWorld: self.gameWorld, gameCameraNode: self.player)
        self.loadPlayerHUD()
        
        self.configurePlayer(mapManager: self.mapManager)
        self.configurePlayerHUD(statusBar: self.statusBar, player: self.player)
        
        self.nextState = .battle
    }
    
    func loadPlayerHUD() {
        self.loadStatusBar()
        let playerHUD = PlayerHUD()
        self.addChild(playerHUD)
        self.playerHUD = playerHUD
    }
    
    func configurePlayerHUD(statusBar: StatusBar, player: PlayerCharacter) {
        player.statusBar = statusBar
        self.playerHUD.configure(playableCharacter: player)
    }
    
    func loadGameWorld() {
        let gameWorld = GameWorld(physicsWorld: self.physicsWorld)
        self.addChild(gameWorld)
        self.gameWorld = gameWorld
    }
    
    func loadGameCamera(gameWorld: GameWorld, gameCameraNode: SKNode = SKNode()) {
        let gameCamera = GameCamera()
        gameWorld.addChild(gameCamera)
        gameCamera.node = gameCameraNode
        gameCamera.update()
        self.gameCamera = gameCamera
    }
    
    func loadPlayer(gameWorld: GameWorld) {
        let playerData = MemoryCard.sharedInstance.playerData!
        guard let characterData = playerData.selectedCharacter() else { fatalError() }
        let player = PlayerCharacter(characterData: characterData)
        player.zPosition = BattleScene.zPositionType.player.rawValue
        gameWorld.addChild(player)
        self.player = player;
    }
    
    func configurePlayer(mapManager: MapManager) {
        self.player.configure(mapManager: mapManager)
    }
    
    func loadStatusBar() {
        let statusBar = StatusBar()
        self.addChild(statusBar)
        self.statusBar = statusBar
    }
    
    func loadMapManager(player: PlayerCharacter) {
        let mapManager = MapManager(mapManagerDelegate: self)
        mapManager.reload(position: player.position)
        self.mapManager = mapManager
    }
    
    override func touchDown(touch: UITouch) {
        self.player.touchDown(touch: touch)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.player.update()
        super.update(currentTime)
        if self.state == self.nextState {
            switch self.state {
            case .loading:
                break
            case .battle:
                self.gameCamera.update(useLerp: true)
                self.mapManager.update(position: self.player.position)
                break
            case .battleEnd:
                break
            case .battleEndInterval:
                if currentTime - self.battleEndTime > 2 {
                    self.nextState = .showBattleResult
                }
                break
            case .showBattleResult:
                break
            case .mainMenu:
                break
            case .credits:
                break
            }
        } else {
            self.state = self.nextState
            switch self.nextState {
            case .loading:
                break
            case .battle:
                if self.battleBeginTime == 0 {
                    self.battleBeginTime = currentTime
                }
                break
            case .battleEnd:
                self.battleEndTime = currentTime
                self.nextState = .battleEndInterval
                break
            case .battleEndInterval:
                break
            case .showBattleResult:
                break
            case .mainMenu:
                Music.sharedInstance.stop()
                self.view?.presentScene(MainMenuScene(), transition: GameScene.defaultTransition)
                break
            case .credits:
                self.view?.presentScene(CreditsScene(), transition: GameScene.defaultTransition)
                break
            }
        }
    }
    
    override func fpsCountUpdate(fps: Int) {
        if fps >= 30 {
            if self.needMusic {
                self.needMusic = false
                Music.sharedInstance.playMusic(withType: .battle)
            }
        }
    }
    
    override func updateSize() {
        super.updateSize()
        self.gameCamera.update()
    }
    
    #if os(OSX)
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        self.player.keyDown(with: event)
    }
    #endif
}

extension BattleScene {
    
    func randomCharacter(random: GKMersenneTwisterRandomSource, distance: CGFloat) -> PlayableCharacter {
        let playableCharacter = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        return playableCharacter
    }
    
    func randomTile(random: GKMersenneTwisterRandomSource, distance: CGFloat) -> Int {
        var id = 0
        let distance = Float(distance)
        if random.nextUniform() < distance / 2.0 / 100.0 {
            id = 33 + random.nextInt(upperBound: 6) // wall
        } else if random.nextUniform() < distance / 100.0 {
            id = 2 + random.nextInt(upperBound: 7) // dirt/grass
        } else if random.nextUniform() < 1.0 / 1000.0 {
            id = 721 + random.nextInt(upperBound: 2) // gem
        }
        return id
    }
    
    func fillTile(_ mapManagerDelegate: MapManager, _ tiledMap: TiledMap, id: Int, x: Int, y: Int) {
        let id = self.randomTile(random: tiledMap.random, distance: CGPoint(x: tiledMap.region.x, y: tiledMap.region.y).length())
        if id > 0 {
            let texture = tiledMap.texture(id: id)
            if !self.addTile(mapManagerDelegate, tiledMap, id: id, texture: texture, x: x, y: y) {
                tiledMap.addChild(id: id, texture: texture, x: x, y: y)
            }
        }
    }
    
    func addTile(_ mapManagerDelegate: MapManager, _ tiledMap: TiledMap, id: Int, texture: SKTexture?, x: Int, y: Int) -> Bool {
        var handled = true
        switch id {
        case 0:
            self.fillTile(mapManagerDelegate, tiledMap, id: id, x: x, y: y)
            break
        case 33...38:
            if let wall = Wall(texture: texture, x: x, y: y) {
                tiledMap.addChild(wall)
            }
            break
        default:
            handled = false
            break
        }
        return handled
    }
    
    func addObjectGroup(_ mapManagerDelegate: MapManager, _ tiledMap: TiledMap, objectGroup: TiledObjectGroup) {
        
        for object in objectGroup.objectList {
            switch object.type {
            case "\(Wall.self)":
                tiledMap.addChild(Wall(object: object))
                break
            default:
                tiledMap.addChild(Wall(object: object))
                break
            }
        }
    }
    
    func addMap(_ mapManagerDelegate: MapManager, tiledMap: TiledMap) {
        guard let mapManager = self.mapManager  else { return }
        let distance = CGPoint(x: tiledMap.region.x, y: tiledMap.region.y).length()
        if distance > 2.0 {
            guard let random = tiledMap.random else { return }
            let character = self.randomCharacter(random: random, distance: distance)
            character.configure(mapManager: mapManager)
            character.position = tiledMap.position + TiledTile.position(x: 15, y: 15)
            self.gameWorld.addChild(character)
        }
    }
}
