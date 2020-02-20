//
//  MainMenuScene.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class MainMenuScene: GameScene {

    enum state: String {
        case mainMenu
        case battle
    }
    
    var state: state = .mainMenu
    var nextState: state = .mainMenu
    
    override func load() {
        super.load()
        
        MemoryCard.sharedInstance.saveGame()
        
        let playerData = MemoryCard.sharedInstance.playerData!
        playerData.points = playerData.points + 1
        print(playerData.points)
        
        self.backgroundColor = GameColors.backgroundColor
        
        let buttonPlay = Button(imageNamed: "button_233x55", x: 71, y: 604, horizontalAlignment: .center, verticalAlignment: .bottom)
        buttonPlay.setIcon(imageNamed: "Play")
        buttonPlay.set(color: GameColors.controlRed, blendMode: .add)
        self.addChild(buttonPlay)
        buttonPlay.addHandler { [weak self] in
            guard let `self` = self else { return }
            self.nextState = .battle
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if self.state == self.nextState {
            
            switch self.state {
                
            case .mainMenu:
                break
            case .battle:
                break
            }
        } else {
            self.state = self.nextState
            
            switch self.nextState {
                
            case .mainMenu:
                break
            case .battle:
                Music.sharedInstance.stop()
                self.view?.presentScene(BattleScene(), transition: GameScene.defaultTransition)
                break
            }
        }
    }
    
    override func fpsCountUpdate(fps: Int) {
        if fps >= 30 {
            if self.needMusic {
                self.needMusic = false
                Music.sharedInstance.playMusic(withType: .menu)
            }
        }
    }
}
