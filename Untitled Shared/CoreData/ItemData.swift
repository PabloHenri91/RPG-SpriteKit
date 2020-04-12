//
//  ItemData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 29/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData
import SpriteKit

extension MemoryCard {

    func newItemData() -> ItemData {
        let itemData: ItemData = self.insertNewObject()
        // ???
        return itemData
    }
    
}

extension ItemData {
    
    func load(item: Item) {
        let color = item.color.ciColor()
        self.colorBlue = Double(color.blue)
        self.colorGreen = Double(color.green)
        self.colorRed = Double(color.red)
        self.level = Int16(item.level)
        self.rarity = Int16(item.rarity.rawValue)
        self.skin = Int16(item.skin)
    }
    
    func color() -> SKColor {
        let red = CGFloat(self.colorRed)
        let green = CGFloat(self.colorGreen)
        let blue = CGFloat(self.colorBlue)
        return SKColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
