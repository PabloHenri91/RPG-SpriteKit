//
//  BattleSceneTest.swift
//  BattleSceneTest
//
//  Created by Pablo Henrique Bertaco on 05/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Untitled

class BattleSceneTest: XCTestCase {
    
    var scene: BattleScene?
    var currentTime: TimeInterval = 0
    
    override func setUp() {
        
    }
    
    override func invokeTest() {
        guard let scene = GameScene.current as? LoadScene else { return }
        scene.view?.presentScene(BattleScene())
        self.scene = GameScene.current as? BattleScene
        let size = CGSize(width: 480, height: 270)
        self.scene?.view?.window?.setFrame(CGRect(origin: CGPoint(x: 0, y: 0), size: size), display: true)
        GameScene.viewBoundsSize = size
        self.scene?.updateSize()
        super.invokeTest()
    }

    override func tearDown() {
        
    }

    func testExample() {
        guard let _ = self.scene else { XCTFail(); return }
        
        self.updateScene()
        
        self.touch(position: .zero)
        
        self.updateScene()
    }
    
    func updateScene(frames: Int = 60) {
        guard let scene = self.scene else { return }
        for _ in 0...frames {
            self.currentTime = self.currentTime + 1.0 / 60.0
            scene.update(self.currentTime)
            print(self.currentTime)
        }
    }
    
    func touch(position: CGPoint) {
        
        let origin = (NSApplication.shared.windows.first?.frame.origin ?? .zero)
        
        let scale = CGPoint(x: GameScene.defaultSize.width / GameScene.viewBoundsSize.width,
                            y: GameScene.defaultSize.height / GameScene.viewBoundsSize.height)
        
        self.touch(offset: origin * scale, position: position)
    }
    
    func touch(offset: CGPoint, position: CGPoint) {
        guard let scene = self.scene else { return }
        
        let mouseCursorPosition = offset + position
        
        let mouseEventSource = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
        
        guard let event = CGEvent(mouseEventSource: mouseEventSource, mouseType: .leftMouseDown, mouseCursorPosition: mouseCursorPosition, mouseButton: .left) else { return }
        
        guard let touch = UITouch(cgEvent: event) else { return }
        
        scene.touchDown(touch: touch)
        
        print(touch.location(in: scene))
    }

}
