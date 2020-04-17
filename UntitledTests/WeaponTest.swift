//
//  WeaponTest.swift
//  UntitledTests
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Untitled

class WeaponTest: XCTestCase {

    func testDamage() throws {
        
        var weapon: Weapon!
        var character: PlayableCharacter!
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(100, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 5, rarity: .common)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(146, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .uncommon)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(146, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .rare)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(214, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .heroic)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(314, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .epic)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(459, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .legendary)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(673, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .supreme)
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(10, character.strength)
        XCTAssertEqual(985, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .supreme)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .none)
        XCTAssertEqual(100, character.strength)
        XCTAssertEqual(9850, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 2, rarity: .supreme)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .none)
        XCTAssertEqual(100, character.strength)
        XCTAssertEqual(10835, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 10, rarity: .supreme)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .none)
        XCTAssertEqual(100, character.strength)
        XCTAssertEqual(23225, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common)
        character = PlayableCharacter(type: .none, level: 30, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(39, character.strength)
        XCTAssertEqual(390, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .none, secondaryAttribute: .none)
        XCTAssertEqual(70, character.strength)
        XCTAssertEqual(700, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .none, secondaryAttribute: .strength)
        XCTAssertEqual(85, character.strength)
        XCTAssertEqual(850, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .none)
        XCTAssertEqual(100, character.strength)
        XCTAssertEqual(1000, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .uncommon)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .none)
        XCTAssertEqual(100, character.strength)
        XCTAssertEqual(1464, GameMath.damage(weapon: weapon, character: character))
        
        weapon = Weapon(type: .melee, level: 1, rarity: .uncommon)
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .none)
        character.strength = 50
        XCTAssertEqual(732, GameMath.damage(weapon: weapon, character: character))
    }
    
    func testDamageMultiplier() {
        
        let armor = Armor(level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        var weapon: Weapon!
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common, color: Element.randomColor(type: .water))
        XCTAssertEqual(157, (100 * GameMath.damageMultiplier(weapon: weapon, armor: armor)).rounded())
        
        weapon = Weapon(type: .melee, level: 1, rarity: .common, color: Element.randomColor(type: .ice))
        XCTAssertEqual(64, (100 * GameMath.damageMultiplier(weapon: weapon, armor: armor)).rounded())
    }
    
    func testTotalDamage() {
        
        let character = PlayableCharacter(type: .mage, level: 1, primaryAttribute: .wisdom, secondaryAttribute: .intelligence)
        let targer = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .constitution, secondaryAttribute: .strength)
        
        XCTAssertEqual(300, character.health)
        XCTAssertEqual(3000, targer.health)
        
        character.weapon = Weapon(type: .melee, level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        targer.armor = nil
        XCTAssertEqual(100, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .melee, level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        targer.armor = Armor(level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        XCTAssertEqual(91, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .ranged, level: 1, rarity: .common, color: Element.randomColor(type: .ice))
        targer.armor = Armor(level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        XCTAssertEqual(58, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .melee, level: 1, rarity: .common, color: Element.randomColor(type: .water))
        targer.armor = Armor(level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        XCTAssertEqual(143, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .melee, level: 5, rarity: .supreme, color: Element.randomColor(type: .water))
        targer.armor = Armor(level: 5, rarity: .supreme, color: Element.randomColor(type: .fire))
        XCTAssertEqual(143, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .ranged, level: 10, rarity: .supreme, color: Element.randomColor(type: .water))
        targer.armor = Armor(level: 10, rarity: .supreme, color: Element.randomColor(type: .fire))
        XCTAssertEqual(143, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .melee, level: 10, rarity: .supreme, color: Element.randomColor(type: .water))
        targer.armor = nil
        XCTAssertEqual(2323, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .melee, level: 10, rarity: .supreme, color: Element.randomColor(type: .water))
        targer.armor = Armor(level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        XCTAssertEqual(3317, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = nil
        targer.armor = Armor(level: 1, rarity: .common, color: Element.randomColor(type: .fire))
        XCTAssertEqual(0, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .magic, level: 10, rarity: .supreme, color: Element.randomColor(type: .fire))
        targer.armor = Armor(level: 10, rarity: .legendary, color: Element.randomColor(type: .fire))
        XCTAssertEqual(160, GameMath.damage(character: character, target: targer).rounded())
        
        character.weapon = Weapon(type: .magic, level: 10, rarity: .supreme, color: Element.randomColor(type: .fire))
        targer.armor = Armor(level: 10, rarity: .supreme, color: Element.randomColor(type: .fire))
        XCTAssertEqual(109, GameMath.damage(character: character, target: targer).rounded())
    }

}
