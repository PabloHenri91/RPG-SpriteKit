//
//  PlayableCharacter.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 15/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class PlayableCharacter: NonPlayableCharacter {
    
    var statusBar: StatusBar!
    
    var maxHealth: CGFloat = 0
    var maxMana: CGFloat = 0
    var mana: CGFloat = 0
    var health: CGFloat = 0
    
    var dead = false
    
    var level = 1

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
