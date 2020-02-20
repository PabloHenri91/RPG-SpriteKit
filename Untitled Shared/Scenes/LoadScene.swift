//
//  LoadScene.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class LoadScene: GameScene {
    
    weak var gameWorld: GameWorld!
    weak var gameCamera: GameCamera!
    
    init() {
        GameScene.defaultSize = CGSize(width: 375, height: 667)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func load() {
        super.load()
        #if DEBUG
        self.view?.showsFPS = true
        #endif
        
        Label.defaultFontName = .kenPixel
        Label.defaultColor = GameColors.fontWhite
        
        self.backgroundColor = GameColors.backgroundColor
        
        self.addChild(Label(text: "TOUCH TO START", x: 187, y: 620, horizontalAlignment: .center, verticalAlignment: .center))
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
