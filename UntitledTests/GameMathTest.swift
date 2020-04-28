//
//  GameMathTest.swift
//  UntitledTests
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Untitled

class GameMathTest: XCTestCase {
    
    func testXP() {
        
        var character: PlayableCharacter!
        
        character = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
        
        character.update(xp: 500)
        XCTAssertEqual(1, character.level)
        XCTAssertEqual(500, character.xp)
        
        character.update(xp: 500)
        XCTAssertEqual(2, character.level)
        XCTAssertEqual(0, character.xp)
        
        character.update(xp: 1399)
        XCTAssertEqual(2, character.level)
        XCTAssertEqual(1399, character.xp)
        
        character.update(xp: 1)
        XCTAssertEqual(3, character.level)
        XCTAssertEqual(0, character.xp)
        
        character.update(xp: 1)
        XCTAssertEqual(3, character.level)
        XCTAssertEqual(1, character.xp)
        
        character.update(xp: 1960 - 1 + 2744)
        XCTAssertEqual(5, character.level)
        XCTAssertEqual(0, character.xp)
        
        character.update(xp: 12347670)
        XCTAssertEqual(26, character.level)
        XCTAssertEqual(1107575, character.xp)
        
        XCTAssertEqual(1000, GameMath.xp(level: 1))
        XCTAssertEqual(1400, GameMath.xp(level: 2))
        XCTAssertEqual(1960, GameMath.xp(level: 3))
        XCTAssertEqual(2744, GameMath.xp(level: 4))
        XCTAssertEqual(3842, GameMath.xp(level: 5))
        XCTAssertEqual(5378, GameMath.xp(level: 6))
        XCTAssertEqual(7530, GameMath.xp(level: 7))
        XCTAssertEqual(10541, GameMath.xp(level: 8))
        XCTAssertEqual(14758, GameMath.xp(level: 9))
        XCTAssertEqual(20661, GameMath.xp(level: 10))
        XCTAssertEqual(28925, GameMath.xp(level: 11))
        XCTAssertEqual(40496, GameMath.xp(level: 12))
        XCTAssertEqual(56694, GameMath.xp(level: 13))
        XCTAssertEqual(79371, GameMath.xp(level: 14))
        XCTAssertEqual(111120, GameMath.xp(level: 15))
        XCTAssertEqual(155568, GameMath.xp(level: 16))
        XCTAssertEqual(217795, GameMath.xp(level: 17))
        XCTAssertEqual(304913, GameMath.xp(level: 18))
        XCTAssertEqual(426879, GameMath.xp(level: 19))
        XCTAssertEqual(597630, GameMath.xp(level: 20))
        XCTAssertEqual(836683, GameMath.xp(level: 21))
        XCTAssertEqual(1171356, GameMath.xp(level: 22))
        XCTAssertEqual(1639898, GameMath.xp(level: 23))
        XCTAssertEqual(2295857, GameMath.xp(level: 24))
        XCTAssertEqual(3214200, GameMath.xp(level: 25))
        XCTAssertEqual(4499880, GameMath.xp(level: 26))
        XCTAssertEqual(6299831, GameMath.xp(level: 27))
        XCTAssertEqual(8819764, GameMath.xp(level: 28))
        XCTAssertEqual(12347670, GameMath.xp(level: 29))
    }
    
    func testCalculateAttributes() throws {
        
        var character: PlayableCharacter!
        
        character = PlayableCharacter(type: .warrior, level: 1, primaryAttribute: .constitution, secondaryAttribute: .strength)
        XCTAssertEqual(13, character.constitution)
        XCTAssertEqual(12, character.strength)
        XCTAssertEqual(10, character.agility)
        XCTAssertEqual(10, character.dexterity)
        XCTAssertEqual(10, character.wisdom)
        XCTAssertEqual(10, character.intelligence)
        
        character = PlayableCharacter(type: .warrior, level: 1, primaryAttribute: .strength, secondaryAttribute: .agility)
        XCTAssertEqual(12, character.constitution)
        XCTAssertEqual(13, character.strength)
        XCTAssertEqual(11, character.agility)
        XCTAssertEqual(10, character.dexterity)
        XCTAssertEqual(10, character.wisdom)
        XCTAssertEqual(10, character.intelligence)
        
        character = PlayableCharacter(type: .warrior, level: 1, primaryAttribute: .agility, secondaryAttribute: .dexterity)
        XCTAssertEqual(12, character.constitution)
        XCTAssertEqual(12, character.strength)
        XCTAssertEqual(12, character.agility)
        XCTAssertEqual(11, character.dexterity)
        XCTAssertEqual(10, character.wisdom)
        XCTAssertEqual(10, character.intelligence)
        
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .constitution, secondaryAttribute: .strength)
        XCTAssertEqual(100, character.constitution)
        XCTAssertEqual(85, character.strength)
        XCTAssertEqual(39, character.agility)
        XCTAssertEqual(39, character.dexterity)
        XCTAssertEqual(39, character.wisdom)
        XCTAssertEqual(39, character.intelligence)
        
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .agility)
        XCTAssertEqual(70, character.constitution)
        XCTAssertEqual(100, character.strength)
        XCTAssertEqual(54, character.agility)
        XCTAssertEqual(39, character.dexterity)
        XCTAssertEqual(39, character.wisdom)
        XCTAssertEqual(39, character.intelligence)
        
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .agility, secondaryAttribute: .dexterity)
        XCTAssertEqual(70, character.constitution)
        XCTAssertEqual(70, character.strength)
        XCTAssertEqual(70, character.agility)
        XCTAssertEqual(54, character.dexterity)
        XCTAssertEqual(39, character.wisdom)
        XCTAssertEqual(39, character.intelligence)
    }
    
    func testHealth() {
        
        var character: PlayableCharacter!
        
        character = PlayableCharacter(type: .mage, level: 1, primaryAttribute: .wisdom, secondaryAttribute: .intelligence)
        XCTAssertEqual(10, character.constitution)
        XCTAssertEqual(300, character.health)
        
        character = PlayableCharacter(type: .mage, level: 1, primaryAttribute: .wisdom, secondaryAttribute: .constitution)
        XCTAssertEqual(11, character.constitution)
        XCTAssertEqual(330, character.health)
        
        character = PlayableCharacter(type: .mage, level: 1, primaryAttribute: .constitution, secondaryAttribute: .intelligence)
        XCTAssertEqual(12, character.constitution)
        XCTAssertEqual(360, character.health)
        
        character = PlayableCharacter(type: .warrior, level: 1, primaryAttribute: .wisdom, secondaryAttribute: .intelligence)
        XCTAssertEqual(12, character.constitution)
        XCTAssertEqual(360, character.health)
        
        character = PlayableCharacter(type: .warrior, level: 1, primaryAttribute: .wisdom, secondaryAttribute: .constitution)
        XCTAssertEqual(12, character.constitution)
        XCTAssertEqual(360, character.health)
        
        character = PlayableCharacter(type: .warrior, level: 1, primaryAttribute: .constitution, secondaryAttribute: .intelligence)
        XCTAssertEqual(13, character.constitution)
        XCTAssertEqual(390, character.health)
        
        character = PlayableCharacter(type: .mage, level: 30, primaryAttribute: .wisdom, secondaryAttribute: .intelligence)
        XCTAssertEqual(39, character.constitution)
        XCTAssertEqual(1170, character.health)
        
        character = PlayableCharacter(type: .mage, level: 30, primaryAttribute: .wisdom, secondaryAttribute: .constitution)
        XCTAssertEqual(54, character.constitution)
        XCTAssertEqual(1620, character.health)
        
        character = PlayableCharacter(type: .mage, level: 30, primaryAttribute: .constitution, secondaryAttribute: .intelligence)
        XCTAssertEqual(70, character.constitution)
        XCTAssertEqual(2100, character.health)
        
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .wisdom, secondaryAttribute: .intelligence)
        XCTAssertEqual(70, character.constitution)
        XCTAssertEqual(2100, character.health)
        
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .wisdom, secondaryAttribute: .constitution)
        XCTAssertEqual(85, character.constitution)
        XCTAssertEqual(2550, character.health)
        
        character = PlayableCharacter(type: .warrior, level: 30, primaryAttribute: .constitution, secondaryAttribute: .intelligence)
        XCTAssertEqual(100, character.constitution)
        XCTAssertEqual(3000, character.health)
    }

}
