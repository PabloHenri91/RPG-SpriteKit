//
//  WeaponData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {
    
    func newWeaponData(weapon: Weapon) -> WeaponData {
        
        let weaponData: WeaponData = self.insertNewObject()
        weaponData.load(item: weapon)
        return weaponData
    }
}
