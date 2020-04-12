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
