//
//  Arrow.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Arrow: Item {

    static var skinList: [String] = [
        "arrow0"
    ]
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Arrow.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
}
