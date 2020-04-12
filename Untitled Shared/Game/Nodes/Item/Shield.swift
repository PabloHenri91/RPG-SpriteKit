//
//  Shield.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Shield: Item {

    static var skinList: [String] = [
        "shield0"
    ]
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Shield.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
}
