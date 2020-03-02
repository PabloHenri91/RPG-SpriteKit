//
//  BattleScene.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BattleScene: GameScene {
    
    weak var gameWorld: GameWorld!
    weak var gameCamera: GameCamera!
    weak var player: Player!
    weak var statusBar: StatusBar!
    
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
    
    override func load() {
        super.load()
        
        let playerData = MemoryCard.sharedInstance.playerData!
        playerData.points = playerData.points + 1
        print(playerData.points)
        
        self.backgroundColor = GameColors.backgroundColor
        
        self.loadGameWorld()
        self.loadMapManager(gameWorld: self.gameWorld)
        self.loadPlayer(gameWorld: self.gameWorld)
        self.loadGameCamera(gameWorld: self.gameWorld, gameCameraNode: self.player)
        self.loadStatusBar()
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
    
    func loadPlayer(gameWorld: GameWorld) {
        let player = Player()
        gameWorld.addChild(player)
        self.player = player;
    }
    
    func loadStatusBar() {
        let statusBar = StatusBar()
        self.addChild(statusBar)
        self.statusBar = statusBar
    }
    
    func loadMapManager(gameWorld: GameWorld) {
        let mapManager = MapManager()
        gameWorld.addChild(mapManager)
        mapManager.reload()
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
}
