//
//  MapNode.swift
//  Untitled iOS
//
//  Created by John Reis on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class MapNode: SKSpriteNode {
 
    init() {
        super.init(texture: SKTexture(imageNamed: "untitledmap"), color: .white, size: GameScene.defaultSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
