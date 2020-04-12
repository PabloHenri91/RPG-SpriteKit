//
//  ShieldData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {
    
    func newShieldData(shield: Shield) -> ShieldData {
        
        let shieldData: ShieldData = self.insertNewObject()
        shieldData.load(item: shield)
        return shieldData
    }
}
