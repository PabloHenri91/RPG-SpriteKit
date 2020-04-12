//
//  Weapon.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 23/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Weapon: Item {
    
    enum type: Int {
        case none
        case melee
        case magic
        case ranged
    }
    
    var type: type = .none
    
    static var skinListMelee: [String] = [
        "sword0"
    ]
    
    static var skinListMagic: [String] = [
        "staff0"
    ]
    
    static var skinListRanged: [String] = [
        "bow0"
    ]
    
    static var nameList: [String: String] = [
        "sword0": "Sword",
        "staff0": "Staff",
        "bow0": "Bow",
    ]
    
    init(type: type, level: Int = 1, rarity: Item.rarity = .common, color: SKColor? = nil, skin: Int = 0) {
        self.type = type
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    init?(weaponData: WeaponData?) {
        guard let weaponData = weaponData else { return nil }
        self.type = Weapon.type(rawValue: Int(weaponData.type)) ?? .none
        super.init(itemData: weaponData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func skinName(index i: Int) -> String? {
        var name: String? = nil
        
        switch self.type {
        case .none:
            break
        case .melee:
            name = Weapon.skinListMelee[i]
            break
        case .magic:
            name = Weapon.skinListMagic[i]
            break
        case .ranged:
            name = Weapon.skinListRanged[i]
            break
        }
        
        return name
    }
    
    override func skinTexture(skin: Int) -> SKTexture {
        var texture: SKTexture? = nil
        if let name = self.skinName(index: skin) {
            texture = SKTexture(imageNamed: name, filteringMode: GameScene.defaultFilteringMode)
        }
        return texture ?? super.skinTexture(skin: skin)
    }
    
    override var description: String {
        let weaponName = Weapon.nameList[self.skinName(index: self.skin) ?? ""] ?? "null"
        return "\(Item.description(rarity: self.rarity)) \(self.element) \(weaponName) Lvl. \(self.level)"
    }
}
