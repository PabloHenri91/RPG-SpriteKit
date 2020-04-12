//
//  BaseBar.swift
//  RPG-SpriteKit
//
//  Created by John Reis on 02/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BaseBar: Control {
    
    var barMaxWidth: CGFloat = 1
    
    weak var bar: SKSpriteNode!
    
    init(background: String, border: String, x: CGFloat, y: CGFloat, color: SKColor) {
        super.init(imageNamed: background, x: x, y: y)
        
        let bar = SKSpriteNode(texture: nil, color: .white, size: self.size)
        bar.color = color
        bar.colorBlendFactor = 1
        bar.position = CGPoint(x: 0, y: -self.size.height / 2)
        bar.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.addChild(bar)
        self.bar = bar
        
        let border = Control(imageNamed: border, x: 0, y: 0)
        border.color = color
        border.colorBlendFactor = 0.5
        self.addChild(border)
        
        self.barMaxWidth = self.size.width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with value: CGFloat, from maxValue: CGFloat) {
        self.bar.size.width = self.barMaxWidth * value / maxValue
    }
}
