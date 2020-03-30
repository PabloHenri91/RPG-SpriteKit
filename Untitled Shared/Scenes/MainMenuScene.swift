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
        case continueGame
        case loadGame
        case newGame
    }
    
    var state: state = .mainMenu
    var nextState: state = .mainMenu
    
    override func load() {
        super.load()
        
        MemoryCard.sharedInstance.saveGame()
        
        self.loadTitle()
        self.loadButtons()
    }
    
    func loadButtons() {
        
        if MemoryCard.sharedInstance.playerData.selectedCharacter() != nil {
            let buttonContinue = Button(imageNamed: "button_110x26", text: "Continue", x: 185, y: 162, horizontalAlignment: .center, verticalAlignment: .bottom)
            self.addChild(buttonContinue)
            buttonContinue.addHandler { [weak self] in
                guard let `self` = self else { return }
                self.nextState = .continueGame
            }
            
            let buttonLoadGame = Button(imageNamed: "button_110x26", text: "Load Game", x: 185, y: 198, horizontalAlignment: .center, verticalAlignment: .bottom)
            self.addChild(buttonLoadGame)
            buttonLoadGame.addHandler { [weak self] in
                guard let `self` = self else { return }
                self.nextState = .loadGame
            }
        }
        
        let buttonNewGame = Button(imageNamed: "button_110x26", text: "New Game", x: 185, y: 234, horizontalAlignment: .center, verticalAlignment: .bottom)
        self.addChild(buttonNewGame)
        buttonNewGame.addHandler { [weak self] in
            guard let `self` = self else { return }
            self.nextState = .newGame
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if self.state == self.nextState {
            
            switch self.state {
                
            case .mainMenu:
                break
            case .continueGame:
                break
            case .loadGame:
                break
            case .newGame:
                break
            }
        } else {
            self.state = self.nextState
            
            switch self.nextState {
                
            case .mainMenu:
                break
            case .continueGame:
                Music.sharedInstance.stop()
                self.view?.presentScene(BattleScene(), transition: GameScene.defaultTransition)
                break
            case .loadGame:
                self.view?.presentScene(LoadGameScene(), transition: GameScene.defaultTransition)
                break
            case .newGame:
                self.view?.presentScene(NewGameScene(), transition: GameScene.defaultTransition)
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
