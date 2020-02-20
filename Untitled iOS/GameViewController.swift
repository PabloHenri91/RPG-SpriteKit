//
//  GameViewController.swift
//  Untitled iOS
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as? SKView)?.presentScene(LoadScene())
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let view = (self.view as? SKView) else { return }
        guard let scene = view.scene else { return }
        GameScene.viewBoundsSize = view.bounds.size
        GameScene.updateSize()
        scene.size = GameScene.currentSize
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
