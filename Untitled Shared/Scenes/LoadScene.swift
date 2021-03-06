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
        GameScene.defaultSize = CGSize(width: 1920 / 4, height: 1080 / 4)
        GameScene.defaultFilteringMode = .nearest
        
        GameColors.background = GameColors.backgroundColor
        
        Label.defaultFontName = .kenPixel
        Label.defaultColor = GameColors.backgroundColor
        Label.defaultSize = .fontSize8
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func load() {
        super.load()
        #if DEBUG
        self.view?.showsFPS = true
        self.view?.showsPhysics = true
        self.view?.showsNodeCount = true
        #endif
        
        self.loadTitle()
        
        self.addChild(Label(text: "TOUCH TO START", fontColor: GameColors.fontWhite, x: 240, y: 211, horizontalAlignment: .center, verticalAlignment: .center))
        
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
//            self.view?.presentScene(BattleScene())
//            MemoryCard.sharedInstance.reset()
        }
        #endif
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

extension GameScene {
    
    func loadTitle() {
        self.addChild(Label(text: "Title", fontSize: .fontSize16, fontColor: GameColors.fontWhite, x: 240, y: 81, horizontalAlignment: .center, verticalAlignment: .center))
    }
}
