//
//  GameMath.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 15/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class GameMath: NSObject {

    static func maxHealth(character: PlayableCharacter) -> CGFloat {
        let baseHealth = 100.0
        let baseConstitution = 13.0
        let scale = 1.05
        var bonusConstitution = 1.0
        bonusConstitution = bonusConstitution + (character.type == .warrior ? 1 : 0)
        bonusConstitution = bonusConstitution + (character.primaryAttribute == .constitution ? 1 : 0)
        bonusConstitution = bonusConstitution + (character.secondaryAttribute == .constitution ? 1 : 0)
        bonusConstitution = bonusConstitution * Double(character.level)
        let constitution = Double(character.constitution) - baseConstitution + bonusConstitution
        return CGFloat((baseHealth * pow(scale, constitution)).rounded())
    }
}
