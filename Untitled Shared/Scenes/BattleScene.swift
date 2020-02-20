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
        
        let gameWorld = GameWorld()
        self.gameWorld = gameWorld
        self.addChild(gameWorld)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = gameWorld
        
        let gameCamera = GameCamera()
        gameWorld.addChild(gameCamera)
        self.gameCamera = gameCamera
        
        let gameCameraNode = SKNode()
        gameWorld.addChild(gameCameraNode)
        gameCamera.node = gameCameraNode
        gameCamera.update()
        
        self.nextState = .battle
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if self.state == self.nextState {
            switch self.state {
            case .loading:
                break
            case .battle:
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
}
