//
//  CreditsScene.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class CreditsScene: GameScene {
    
    override func load() {
        super.load()
        self.addChild(Label(text: "CREDITS", x: 187, y: 620, horizontalAlignment: .center, verticalAlignment: .center))
    }
    
    override func touchUp(touch: UITouch) {
        super.touchUp(touch: touch)
        Music.sharedInstance.stop()
        self.view?.presentScene(MainMenuScene(), transition: GameScene.defaultTransition)
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
