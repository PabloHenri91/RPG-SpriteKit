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
        super.init(type: .warrior, level: 30, primaryAttribute: .strength, secondaryAttribute: .constitution)
        self.maxMana = 300
        self.mana = 300
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
            
            print(self.position.distanceTo(destination))
            
            if self.position.distanceTo(destination) < 1 {
                self.destination = nil
                self.lastMove = .none
            } else {
                let delta = destination - self.position
                
                if abs(delta.x) > map.tileWidth/2 {
                    if delta.x > 0 {
                        self.moveD = true
                    } else {
                        self.moveA = true
                    }
                }
                
                if abs(delta.y) > map.tileHeight/2 {
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
    
    //@todo mock method only
    func mockSpawnEnemy() {
        let enemy = Enemy(type: .ranger, level: 10, primaryAttribute: .agility, secondaryAttribute: .intelligence)
        enemy.position = self.position
        enemy.health = CGFloat.random(in: 200...500)
        enemy.maxHealth = enemy.health
        enemy.mana = CGFloat.random(in: 200...500)
        enemy.maxMana = enemy.mana
        self.parent?.addChild(enemy)
        Enemy.enemyList.insert(enemy)
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
            
            self.moveA = false
            self.moveS = false
            self.moveD = false
            self.moveW = false
            
            if self.contains(touchLocation) {
                self.destination = nil
                self.lastMove = .none
            } else if (self.touchedEnemy(on: touchLocation) != nil) {
                let enemy = self.touchedEnemy(on: touchLocation)!
                print(enemy.health)
                enemy.updateHealth(with: -CGFloat.random(in: 90...150))
            } else {
                touchLocation = CGPoint(
                    x: ((touchLocation.x) / TiledMap.tileWidth).rounded() * TiledMap.tileWidth,
                    y: ((touchLocation.y) / TiledMap.tileHeight).rounded() * TiledMap.tileHeight)
                self.destination = touchLocation
                self.lastMove = .none
            }
        }
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
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
            case 51:
                self.mockSpawnEnemy()
            break
        case 0, 123:
            self.destination = nil
            self.lastMove = .none
            self.moveA = true
            break
        case 1, 125:
            self.destination = nil
            self.lastMove = .none
            self.moveS = true
            break
        case 2, 124:
            self.destination = nil
            self.lastMove = .none
            self.moveD = true
            break
        case 13, 126:
            self.destination = nil
            self.lastMove = .none
            self.moveW = true
            break
        default:
            break
        }
    }
}