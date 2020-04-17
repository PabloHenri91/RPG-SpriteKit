//
//  PlayableCharacter.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 15/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class PlayableCharacter: NonPlayableCharacter {
    
    var dead = false
    var statusBar: StatusBar!
    var maxHealth: CGFloat = 0
    var health: CGFloat = 0
    var maxMana: CGFloat = 0
    var mana: CGFloat = 0
    var level = 1
    var xp = 0
    var type: type = .warrior
    var primaryAttribute: attribute = .constitution
    var secondaryAttribute: attribute = .strength
    var constitution: CGFloat = 10
    var strength: CGFloat = 10
    var agility: CGFloat = 10
    var dexterity: CGFloat = 10
    var wisdom: CGFloat = 10
    var intelligence: CGFloat = 10
    var backpack: Backpack?
    var armor: Armor?
    var shield: Shield?
    var weapon: Weapon?
    var arrow: Arrow?
    
    init(type: type, level: Int, primaryAttribute: attribute, secondaryAttribute: attribute) {
        self.type = type
        self.level = level
        self.primaryAttribute = primaryAttribute
        self.secondaryAttribute = secondaryAttribute
        super.init()
        self.updateAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func movementSpeed() -> CGFloat {
        return GameMath.movementSpeed(character: self)
    }
    
    func updateAttributes() {
        self.constitution = GameMath.constitution(character: self)
        self.strength = GameMath.strength(character: self)
        self.agility = GameMath.agility(character: self)
        self.dexterity = GameMath.dexterity(character: self)
        self.wisdom = GameMath.wisdom(character: self)
        self.intelligence = GameMath.intelligence(character: self)
        
        self.maxHealth = GameMath.health(character: self)
        self.health = self.maxHealth
        self.maxMana = GameMath.mana(character: self)
        self.mana = self.maxMana
    }
    
    func update(xp value: Int) {
        var xp = GameMath.xp(level: self.level)
        self.xp = self.xp + value
        while self.xp >= xp {
            self.xp = self.xp - xp
            self.level = self.level + 1
            xp = GameMath.xp(level: self.level)
        }
    }
    
    func update(mana value: CGFloat) {
        guard self.dead == false else { return }
        
        self.mana += value
        
        if mana <= 0 { mana = 0 }
        
        if mana >= maxMana { mana = maxMana }
    }
    
    func update(health value: CGFloat) {
        guard self.dead == false else { return }
        
        self.health += value
        
        if (health >= maxHealth) {
            health = maxHealth
        }
        
        if health <= 0 {
            health = 0
            return self.die()
        }
    }
    
    func die() {
        self.dead = true
    }
    
    func typeDescription() -> String {
        switch self.type {
        case .none:
            return "null"
        case .warrior:
            return "Warrior"
        case .mage:
            return "Mage"
        case .ranger:
            return "Ranger"
        }
    }
    
    override var description: String {
        return [
            "\(self.typeDescription()) Lvl. \(self.level)",
            "primaryAttribute: \(self.primaryAttribute)",
            "secondaryAttribute: \(self.secondaryAttribute)",
            "constitution: \(self.constitution)",
            "strength: \(self.strength)",
            "agility: \(self.agility)",
            "dexterity: \(self.dexterity)",
            "wisdom: \(self.wisdom)",
            "intelligence: \(self.intelligence)",
            "\(self.backpack?.description ?? "")",
            "\(self.armor?.description ?? "")",
            "\(self.shield?.description ?? "")",
            "\(self.weapon?.description ?? "")",
            "\(self.arrow?.description ?? "")"
            ].joined(separator: "\n")
    }
    
    enum attribute: Int {
        case none, constitution, strength, agility, dexterity, wisdom, intelligence
    }
    
    enum type: Int {
        case none, warrior, mage, ranger
    }
}
