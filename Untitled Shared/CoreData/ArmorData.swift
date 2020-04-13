//
//  ArmorData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 08/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {
    
    func newArmorData(armor: Armor?) -> ArmorData? {
        guard let armor = armor else { return nil }
        let armorData: ArmorData = self.insertNewObject()
        armorData.load(item: armor)
        return armorData
    }
}
