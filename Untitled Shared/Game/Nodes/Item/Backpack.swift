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
    
    override init(level: Int = 1, rarity: Item.rarity = .common, color: SKColor? = nil, skin: Int = 0) {
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    init?(backpackData: BackpackData?) {
        guard let backpackData = backpackData else { return nil }
        super.init(itemData: backpackData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Backpack.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
    
    override var description: String {
        return "\(Item.description(rarity: self.rarity)) Backpack"
    }
}
