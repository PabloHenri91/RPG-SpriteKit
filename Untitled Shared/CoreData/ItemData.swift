//
//  ItemData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 29/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {

    func newItemData() -> ItemData {
        let itemData: ItemData = self.insertNewObject()
        
        return itemData
    }
    
}
