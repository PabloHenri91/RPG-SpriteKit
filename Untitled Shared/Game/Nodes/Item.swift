//
//  Item.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 23/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Item: NSObject {

    enum rarity: Int {
        case common, uncommon, rare, heroic, epic, legendary, supreme
    }
    
    var level = 1
    var rarity: rarity = .common
}
