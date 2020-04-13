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
    
    var itemList = [Item]()
    
    override init(level: Int? = nil, rarity: Item.rarity? = nil, color: SKColor? = nil, skin: Int? = nil) {
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    override init?(itemData: ItemData?) {
        guard let backpackData = itemData as? BackpackData else { return nil }
        super.init(itemData: backpackData)
        
        for itemData in backpackData.getItemList() {
            if let item = Item.create(itemData: itemData) {
                self.itemList.append(item)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: Backpack.skinList[skin], filteringMode: GameScene.defaultFilteringMode)
    }
    
    override var description: String {
        var textList = ["\(Item.description(rarity: self.rarity)) \(self.element) Backpack Lvl. \(self.level)"]
        for item in self.itemList {
            textList.append(item.description)
        }
        return textList.joined(separator: "\n")
    }
}
