//
//  BattleScene.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BattleScene: GameScene, MapManagerDelegate {
    
    weak var gameWorld: GameWorld!
    weak var gameCamera: GameCamera!
    weak var player: PlayerCharacter!
    weak var statusBar: StatusBar!
    
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
        
        let playerData = MemoryCard.sharedInstance.playerData!
        playerData.points = playerData.points + 1
        
        self.loadGameWorld()
        self.loadStatusBar()
        self.loadPlayer(gameWorld: self.gameWorld, statusBar: self.statusBar)
        self.loadMapManager(player: self.player)
        self.loadGameCamera(gameWorld: self.gameWorld, gameCameraNode: self.player)
        
        self.configurePlayer(mapManager: self.mapManager)
        
        self.nextState = .battle
    }
    
    func loadGameWorld() {
        let gameWorld = GameWorld(physicsWorld: self.physicsWorld)
        self.addChild(gameWorld)
        self.gameWorld = gameWorld
    }
    
    func loadGameCamera(gameWorld: GameWorld, gameCameraNode:SKNode = SKNode()) {
        let gameCamera = GameCamera()
        gameWorld.addChild(gameCamera)
        gameCamera.node = gameCameraNode
        gameCamera.update()
        self.gameCamera = gameCamera
    }
    
    func loadPlayer(gameWorld: GameWorld, statusBar: StatusBar) {
        let player = PlayerCharacter()
        player.zPosition = BattleScene.zPositionType.player.rawValue
        player.statusBar = statusBar
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
    
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        self.player.keyDown(with: event)
    }
}

extension BattleScene {
    
    func addTile(_ mapManagerDelegate: MapManager, _ tiledMap: TiledMap, id: Int, texture: SKTexture, x: Int, y: Int) -> Bool {
        var handled = true
        switch id {
        case 1:
            tiledMap.addChild(TiledTile(texture: texture, x: x, y: y))
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
}
