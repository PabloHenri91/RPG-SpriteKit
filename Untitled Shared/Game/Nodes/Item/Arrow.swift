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
    
    override init(level: Int = 1, rarity: Item.rarity = .common, color: SKColor? = nil, skin: Int = 0) {
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
       
    init?(arrowData: ArrowData?) {
        guard let arrowData = arrowData else { return nil }
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
