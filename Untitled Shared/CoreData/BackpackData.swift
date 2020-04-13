//
//  BackpackData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 08/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {

    func newBackpackData(backpack: Backpack?) -> BackpackData? {
        guard let backpack = backpack else { return nil }
        let backpackData: BackpackData = self.insertNewObject()
        backpackData.load(item: backpack)
        return backpackData
    }
}

extension BackpackData {
    
    func getItemList() -> Set<ItemData> {
        return self.itemList as? Set<ItemData> ?? []
    }
}
