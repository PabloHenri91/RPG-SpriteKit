//
//  ArmorTest.swift
//  UntitledTests
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Untitled

class ArmorTest: XCTestCase {

    func testExample() throws {
        
        var armor: Armor!
        
        armor = Armor(level: 1, rarity: .common)
        XCTAssertEqual(91, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 2, rarity: .common)
        XCTAssertEqual(83, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 3, rarity: .common)
        XCTAssertEqual(75, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 4, rarity: .common)
        XCTAssertEqual(68, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 5, rarity: .common)
        XCTAssertEqual(62, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 1, rarity: .uncommon)
        XCTAssertEqual(62, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 1, rarity: .rare)
        XCTAssertEqual(42, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 1, rarity: .heroic)
        XCTAssertEqual(29, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 1, rarity: .epic)
        XCTAssertEqual(20, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 1, rarity: .legendary)
        XCTAssertEqual(14, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 1, rarity: .supreme)
        XCTAssertEqual(9, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 5, rarity: .supreme)
        XCTAssertEqual(6, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
        
        armor = Armor(level: 10, rarity: .supreme)
        XCTAssertEqual(4, (100 * GameMath.damageMultiplier(armor: armor)).rounded())
    }

}
