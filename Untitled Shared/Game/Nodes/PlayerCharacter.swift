//
//  Player.swift
//  Untitled iOS
//
//  Created by John Reis on 26/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class PlayerCharacter: PlayableCharacter {

    init() {
        super.init(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
    }
    
    init(characterData: CharacterData) {
        let type = PlayableCharacter.type(rawValue: Int(characterData.type)) ?? .none
        let level = Int(characterData.level)
        let primaryAttribute = PlayableCharacter.attribute(rawValue: Int(characterData.primaryAttribute)) ?? .none
        let secondaryAttribute = PlayableCharacter.attribute(rawValue: Int(characterData.secondaryAttribute)) ?? .none
        super.init(type: type, level: level, primaryAttribute: primaryAttribute, secondaryAttribute: secondaryAttribute)
        self.backpack = Backpack(itemData: characterData.backpack)
        self.armor = Armor(itemData: characterData.chest)
        self.shield = Shield(itemData: characterData.leftHand)
        self.arrow = Arrow(itemData: characterData.leftHand)
        self.weapon = Weapon(itemData: characterData.rightHand)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update() {
        self.move()
    }
    
    override func move() {
        guard let map = TiledMap.current else {
            return
        }
        
        if let destination = self.destination {
            
            if self.position.distanceTo(destination).rounded() < map.tileWidth {
                self.stop()
            } else {
                let delta = destination - self.position
                
                if abs(delta.x) > map.tileWidth / 2 {
                    if delta.x > 0 {
                        self.moveD = true
                    } else {
                        self.moveA = true
                    }
                }
                
                if abs(delta.y) > map.tileHeight / 2 {
                    if delta.y > 0 {
                        self.moveW = true
                    } else {
                        self.moveS = true
                    }
                }
            }
        }
        
        super.move()
    }
    
    override func updateMana(with value: CGFloat) {
        super.updateMana(with: value)
        self.statusBar.manaBar.update(with: self.mana, from: self.maxMana)
    }
    
    override func updateHealth(with value: CGFloat) {
        super.updateHealth(with: value)
        self.statusBar.healthBar.update(with: self.health, from: self.maxHealth)
    }
    
    override func die() {
        super.die()
    }
    
    func touchedEnemy(on location:CGPoint) -> Enemy? {
        for enemy in Enemy.enemyList {
            if enemy.contains(location) {
                return enemy
            }
        }
        
        return nil
    }
    
    func touchDown(touch: UITouch) {
        guard let TiledMap = TiledMap.current else {
            return
        }
        
        if let parent = self.parent {
            var touchLocation = touch.location(in: parent)
            
            self.stop()
            
            if let enemy = self.touchedEnemy(on: touchLocation) {
                enemy.updateHealth(with: -CGFloat.random(in: 90...150))
            } else {
                touchLocation = CGPoint(
                    x: ((touchLocation.x) / TiledMap.tileWidth).rounded() * TiledMap.tileWidth,
                    y: ((touchLocation.y) / TiledMap.tileHeight).rounded() * TiledMap.tileHeight)
                self.destination = touchLocation
            }
        }
    }
}
