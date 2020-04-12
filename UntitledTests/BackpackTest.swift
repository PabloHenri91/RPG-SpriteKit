//
//  BackpackTest.swift
//  UntitledTests
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Untitled

class BackpackTest: XCTestCase {
    
    func testSize() throws {
        var backpack: Backpack!
        
        backpack = Backpack(level: 1, rarity: .common)
        XCTAssertEqual(5, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 5, rarity: .common)
        XCTAssertEqual(11, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 10, rarity: .common)
        XCTAssertEqual(11, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 1, rarity: .heroic)
        XCTAssertEqual(14, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 5, rarity: .heroic)
        XCTAssertEqual(21, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 10, rarity: .heroic)
        XCTAssertEqual(33, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 1, rarity: .supreme)
        XCTAssertEqual(44, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 5, rarity: .supreme)
        XCTAssertEqual(65, GameMath.backPackSlots(backpack: backpack))
        
        backpack = Backpack(level: 10, rarity: .supreme)
        XCTAssertEqual(105, GameMath.backPackSlots(backpack: backpack))
    }

}
