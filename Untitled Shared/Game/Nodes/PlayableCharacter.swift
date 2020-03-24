//
//  PlayableCharacter.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 15/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class PlayableCharacter: NonPlayableCharacter {
    
    enum attribute {
        case none, constitution, strength, agility, dexterity, wisdom, intelligence
    }
    
    enum type {
        case none, warrior, mage, ranger
    }
    
    var statusBar: StatusBar!
    
    var maxHealth: CGFloat = 0
    var health: CGFloat = 0
    
    var maxMana: CGFloat = 0
    var mana: CGFloat = 0
    
    var dead = false
    
    var level = 1
    var type: type = .warrior
    var primaryAttribute: attribute = .constitution
    var secondaryAttribute: attribute = .strength
    var constitution = 10 // health
    var strength = 10 // melee damage
    var agility = 10 // movement speed
    var dexterity = 10 // ranged damage
    var wisdom = 10 // mana
    var intelligence = 10 // magic damage
    
    var armor = Armor()
    var weapon = Weapon()
    
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
    
    func updateAttributes() {
        self.maxHealth = GameMath.health(armor: self.armor, character: self)
        self.health = self.maxHealth
        self.maxMana = GameMath.mana(character: self)
        self.mana = self.maxMana
    }
    
    override func movementSpeed() -> CGFloat {
        return GameMath.movementSpeed(character: self)
    }
    
    func updateMana(with value: CGFloat) {
        guard self.dead == false else { return }
        
        self.mana += value
        
        if mana <= 0 { mana = 0 }
        
        if mana >= maxMana { mana = maxMana }
    }
    
    func updateHealth(with value: CGFloat) {
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
        print("die")
    }
}
