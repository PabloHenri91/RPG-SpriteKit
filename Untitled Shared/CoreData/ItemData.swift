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

    func newItemData(item: Item?) -> ItemData? {
        guard let item = item else { return nil }
        var itemData: ItemData? = nil
        switch item {
        case is Armor:
            itemData = self.newArmorData(armor: item as? Armor)
            break
        case is Arrow:
            itemData = self.newArrowData(arrow: item as? Arrow)
            break
        case is Backpack:
            itemData = self.newBackpackData(backpack: item as? Backpack)
            break
        case is Shield:
            itemData = self.newShieldData(shield: item as? Shield)
            break
        case is Weapon:
            itemData = self.newWeaponData(weapon: item as? Weapon)
            break
        default:
            break
        }
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
