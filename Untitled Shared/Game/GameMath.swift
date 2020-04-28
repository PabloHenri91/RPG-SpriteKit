//
//  GameMath.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 15/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class GameMath: NSObject {
    
    static func xp(level: Int) -> Int {
        let value =  1000 * pow(1.4, Double(level - 1))
        return Int(value.rounded())
    }
    
    static func blockChance(shield: Shield?) -> CGFloat {
        guard let shield = shield else { return 0 }
        var value = 1.0 * CGFloat(pow(1.1, 4.0 * Double(shield.rarity.rawValue)))
        value = value * pow(1.1, CGFloat(shield.level))
        value = 1.0 - 1.0 / value
        return value
    }
    
    static func calculate(attribute: PlayableCharacter.attribute, type: PlayableCharacter.type, character: PlayableCharacter) -> CGFloat {
        var base = 10.0
        base = base + (character.type == type ? 1.5 : 0)
        base = base + (character.primaryAttribute == attribute ? 1.5 : 0)
        base = base + (character.secondaryAttribute == attribute ? 0.5 : 0)
        var bonus = 1.0
        bonus = bonus + (character.type == type ? 1.0 : 0)
        bonus = bonus + (character.primaryAttribute == attribute ? 1.0 : 0)
        bonus = bonus + (character.secondaryAttribute == attribute ? 0.5 : 0)
        bonus = bonus * Double(character.level - 1)
        return CGFloat(base + bonus).rounded()
    }
    
    static func health(character: PlayableCharacter) -> CGFloat {
        var value: CGFloat = 30.0
        value = value * GameMath.constitution(character: character)
        return value.rounded()
    }
    
    static func movementSpeed(character: PlayableCharacter) -> CGFloat {
        var value: CGFloat = 9.6
        value = value * GameMath.agility(character: character)
        return value.rounded()
    }
    
    static func mana(character: PlayableCharacter) -> CGFloat {
        var value: CGFloat = 30.0
        value = value * GameMath.wisdom(character: character)
        return value.rounded()
    }
    
    static func damage(weapon: Weapon?, character: PlayableCharacter) -> CGFloat {
        guard let weapon = weapon else { return 0 }
        var value = 10.0 * CGFloat(pow(1.1, 4.0 * Double(weapon.rarity.rawValue)))
        switch weapon.type {
        case .none:
            break
        case .melee:
            value = value * character.strength
            break
        case .magic:
            value = value * character.intelligence
            break
        case .ranged:
            value = value * character.dexterity
            break
        }
        
        value = value * pow(1.1, CGFloat(weapon.level - 1))
        
        return value.rounded()
    }
    
    static func damageMultiplier(armor: Armor?) -> CGFloat {
        guard let armor = armor else { return 1 }
        var value = 1.0 * CGFloat(pow(1.1, 4.0 * Double(armor.rarity.rawValue)))
        value = value * pow(1.1, CGFloat(armor.level))
        value = 1.0 / value
        return value
    }
    
    static func damageMultiplier(weapon: Weapon?, armor: Armor?) -> CGFloat {
        guard let weapon = weapon else { return 0 }
        var value: CGFloat = 1.0
        if let armor = armor {
            if armor.element.weakness == weapon.element.type {
                value = value * (CGFloat.pi / 2.0)
            } else if armor.element.strength == weapon.element.type {
                value = value / (CGFloat.pi / 2.0)
            }
        }
        return value
    }
    
    static func damage(character: PlayableCharacter, target: PlayableCharacter) -> CGFloat {
        var damage = GameMath.damage(weapon: character.weapon, character: character)
        damage = damage * GameMath.damageMultiplier(armor: target.armor)
        damage = damage * GameMath.damageMultiplier(weapon: character.weapon, armor: target.armor)
        return damage
    }

    static func constitution(character: PlayableCharacter) -> CGFloat {
        return GameMath.calculate(attribute: .constitution, type: .warrior, character: character)
    }
    
    static func strength(character: PlayableCharacter) -> CGFloat {
        return GameMath.calculate(attribute: .strength, type: .warrior, character: character)
    }
    
    static func agility(character: PlayableCharacter) -> CGFloat {
        return GameMath.calculate(attribute: .agility, type: .ranger, character: character)
    }
    
    static func dexterity(character: PlayableCharacter) -> CGFloat {
        return GameMath.calculate(attribute: .dexterity, type: .ranger, character: character)
    }
    
    static func wisdom(character: PlayableCharacter) -> CGFloat {
        return GameMath.calculate(attribute: .wisdom, type: .mage, character: character)
    }
    
    static func intelligence(character: PlayableCharacter) -> CGFloat {
        return GameMath.calculate(attribute: .intelligence, type: .mage, character: character)
    }
}
