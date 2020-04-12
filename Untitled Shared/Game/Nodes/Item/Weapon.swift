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
        case melee
        case magic
        case ranged
    }
    
    var type: type = .melee
    
    static var skinListMelee: [String] = [
        "sword0"
    ]
    
    static var skinListMagic: [String] = [
        "staff0"
    ]
    
    static var skinListRanged: [String] = [
        "bow0"
    ]
    
    init(type: type, level: Int = 1, rarity: Item.rarity = .common, color: SKColor? = nil, skin: Int = 0) {
        self.type = type
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func skinTexture(index i: Int) -> SKTexture? {
        var texture: SKTexture? = nil
        
        switch self.type {
        case .melee:
            texture = SKTexture(imageNamed: Weapon.skinListMelee[i], filteringMode: GameScene.defaultFilteringMode)
            break
        case .magic:
            texture = SKTexture(imageNamed: Weapon.skinListMagic[i], filteringMode: GameScene.defaultFilteringMode)
            break
        case .ranged:
            texture = SKTexture(imageNamed: Weapon.skinListRanged[i], filteringMode: GameScene.defaultFilteringMode)
            break
        }
        
        return texture
    }
}
