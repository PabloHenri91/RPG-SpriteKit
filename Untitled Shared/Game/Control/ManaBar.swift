//
//  HealthBar.swift
//  Untitled iOS
//
//  Created by John Reis on 28/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class ManaBar: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "statusBarItemBackground", filteringMode: GameScene.defaultFilteringMode)
        super.init(texture: texture, color: .white, size: texture.size())
        self.position = CGPoint(x: 28, y: -13)
        self.anchorPoint = CGPoint(x: 0, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
