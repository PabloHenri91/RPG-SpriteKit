//
//  Weapon.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 23/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Weapon: Item {
    
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
    
    init(type: type? = nil, level: Int? = nil, rarity: Item.rarity? = nil, color: SKColor? = nil, skin: Int? = nil) {
        self.type = type ?? Weapon.randomType()
        super.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    override init?(itemData: ItemData?) {
        guard let weaponData = itemData as? WeaponData else { return nil }
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
    
    static func randomType() -> type {
        return [.melee, .magic, .ranged].randomElement() ?? .none
    }
    
    enum type: Int {
        case none
        case melee
        case magic
        case ranged
    }
}
