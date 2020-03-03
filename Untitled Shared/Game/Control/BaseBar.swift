//
//  BaseBar.swift
//  RPG-SpriteKit
//
//  Created by John Reis on 02/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

enum BarType {
    case health
    case mana
}

class BaseBar: SKSpriteNode {

    let bar: SKSpriteNode
    let barMaxWidth: CGFloat
    
    init(imageNamed: String) {
        let backgroundTexture = SKTexture(imageNamed: "statusBarItemBackground")
        let texture = SKTexture(imageNamed: imageNamed)
        self.bar = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        self.barMaxWidth = self.bar.size.width
        super.init(texture: backgroundTexture, color: .white, size: backgroundTexture.size())
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.bar.position = CGPoint(x: 1, y: -1)
        self.bar.anchorPoint = CGPoint(x: 0, y: 1)
        self.addChild(bar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with value: CGFloat, from maxValue: CGFloat) {
        let maxBarWidth = self.barMaxWidth
        let factor = (value / maxValue)
        self.bar.size.width = (factor * maxBarWidth)
    }
    
}
