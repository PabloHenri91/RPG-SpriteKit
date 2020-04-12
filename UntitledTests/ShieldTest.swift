//
//  ShieldTest.swift
//  UntitledTests
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Untitled

class ShieldTest: XCTestCase {
    
    func testBlockChance() throws {
        
        var shield: Shield!
        
        shield = Shield(level: 1, rarity: .common)
        XCTAssertEqual(9, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 5, rarity: .common)
        XCTAssertEqual(38, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 10, rarity: .common)
        XCTAssertEqual(61, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 1, rarity: .heroic)
        XCTAssertEqual(71, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 5, rarity: .heroic)
        XCTAssertEqual(80, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 10, rarity: .heroic)
        XCTAssertEqual(88, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 1, rarity: .supreme)
        XCTAssertEqual(91, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 5, rarity: .supreme)
        XCTAssertEqual(94, (100 * GameMath.blockChance(shield: shield)).rounded())
        
        shield = Shield(level: 10, rarity: .supreme)
        XCTAssertEqual(96, (100 * GameMath.blockChance(shield: shield)).rounded())
        
    }

}
