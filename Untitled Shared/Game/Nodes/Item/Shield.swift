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
    
    override init(level: Int? = nil, rarity: Item.rarity? = nil, color: SKColor? = nil, skin: Int? = nil) {
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    override init?(itemData: ItemData?) {
        guard let shieldData = itemData as? ShieldData else { return nil }
        super.init(itemData: shieldData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Shield.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
    
    override var description: String {
        return "\(Item.description(rarity: self.rarity)) \(self.element) Shield Lvl. \(self.level)"
    }
}
