//
//  Backpack.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 08/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Backpack: Item {

    static var skinList: [String] = [
        "backpack0"
    ]
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Backpack.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
}
