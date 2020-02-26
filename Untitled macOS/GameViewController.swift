//
//  GameViewController.swift
//  Untitled macOS
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class GameViewController: NSViewController, NSWindowDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GameScene.viewBoundsSize = self.view.bounds.size
        (self.view as? SKView)?.presentScene(LoadScene())
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        guard let window = self.view.window else { return }
        window.delegate = self
        window.toggleFullScreen(nil)
    }
    
    func windowDidResize(_ notification: Notification) {
        guard let view = (self.view as? SKView) else { return }
        guard let scene = view.scene else { return }
        GameScene.viewBoundsSize = view.bounds.size
        GameScene.updateSize()
        scene.size = GameScene.currentSize
        print(view.bounds.size)
    }
}
