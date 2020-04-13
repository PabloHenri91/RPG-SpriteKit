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
    
    override init(level: Int? = nil, rarity: Item.rarity? = nil, color: SKColor? = nil, skin: Int? = nil) {
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    override init?(itemData: ItemData?) {
        guard let arrowData = itemData as? ArrowData else { return nil }
        super.init(itemData: arrowData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Arrow.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
    
    override var description: String {
        return "\(Item.description(rarity: self.rarity)) \(self.element) Arrow Lvl. \(self.level)"
    }
}
