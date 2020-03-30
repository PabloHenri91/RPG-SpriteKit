//
//  GameMath.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 15/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class GameMath: NSObject {
    
    static func calculate(attribute: PlayableCharacter.attribute, type: PlayableCharacter.type, character: PlayableCharacter) -> CGFloat {
        let base = character.type == type ? 13.0 : 10.0
        var bonus = 1.0
        bonus = bonus + (character.type == type ? 1 : 0)
        bonus = bonus + (character.primaryAttribute == attribute ? 1 : 0)
        bonus = bonus + (character.secondaryAttribute == attribute ? 0.5 : 0)
        bonus = bonus * Double(character.level - 1)
        return CGFloat(base + bonus).rounded()
    }
    
    static func health(character: PlayableCharacter) -> CGFloat {
        var value: CGFloat = 100.0
        value = value * constitution(character: character)
        return value
    }
    
    static func movementSpeed(character: PlayableCharacter) -> CGFloat {
        var value: CGFloat = 9.6
        value = value * agility(character: character)
        return value
    }
    
    static func mana(character: PlayableCharacter) -> CGFloat {
        var value: CGFloat = 100.0
        value = value * wisdom(character: character)
        return value
    }
    
    static func damage(weapon: Weapon, character: PlayableCharacter) -> CGFloat {
        var value = 1.0 * CGFloat(pow(1.1, 4.0 * Double(weapon.rarity.hashValue)))
        switch weapon.type {
        case .melee:
            value = value * strength(character: character)
            break
        case .magic:
            value = value * intelligence(character: character)
            break
        case .ranged:
            value = value * dexterity(character: character)
            break
        }
        return value
    }

    static func constitution(character: PlayableCharacter) -> CGFloat {
        return calculate(attribute: .constitution, type: .warrior, character: character)
    }
    
    static func strength(character: PlayableCharacter) -> CGFloat {
        return calculate(attribute: .strength, type: .warrior, character: character)
    }
    
    static func agility(character: PlayableCharacter) -> CGFloat {
        return calculate(attribute: .agility, type: .ranger, character: character)
    }
    
    static func dexterity(character: PlayableCharacter) -> CGFloat {
        return calculate(attribute: .dexterity, type: .ranger, character: character)
    }
    
    static func wisdom(character: PlayableCharacter) -> CGFloat {
        return calculate(attribute: .wisdom, type: .mage, character: character)
    }
    
    static func intelligence(character: PlayableCharacter) -> CGFloat {
        return calculate(attribute: .intelligence, type: .mage, character: character)
    }
}
