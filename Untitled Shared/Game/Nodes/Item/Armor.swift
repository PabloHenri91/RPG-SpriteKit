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
    
    override init(level: Int? = nil, rarity: Item.rarity? = nil, color: SKColor? = nil, skin: Int? = nil) {
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    override init?(itemData: ItemData?) {
        guard let armorData = itemData as? ArmorData else { return nil }
        super.init(itemData: armorData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Armor.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
    
    override var description: String {
        return "\(Item.description(rarity: self.rarity)) \(self.element) Armor Lvl. \(self.level)"
    }
}
