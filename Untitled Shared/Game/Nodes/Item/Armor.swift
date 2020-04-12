//
//  Armor.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 23/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Armor: Item {
    
    static var skinList: [String] = [
        "armor0"
    ]
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Armor.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
    
    override var description: String {
        return "\(Item.description(rarity: self.rarity)) \(self.element) Armor\(self.level > 0 ? " +\(self.level)" : "")"
    }
}
