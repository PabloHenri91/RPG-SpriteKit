//
//  Weapon.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 23/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Weapon: Item {

    enum type {
        case melee, magic, ranged
    }
    
    var type: type = .melee
}
