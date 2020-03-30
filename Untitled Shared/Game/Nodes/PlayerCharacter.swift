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
    
    //@todo mock method only
    func mockSpawnEnemy() {
        guard let mapManager = MapManager.current else { return }
        let enemy = Enemy(type: .ranger, level: 10, primaryAttribute: .agility, secondaryAttribute: .intelligence)
        enemy.configure(mapManager: mapManager)
        enemy.position = self.position
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
        case 12:
            self.loadTexture()
            break
        case 51:
            self.mockSpawnEnemy()
            break
        default:
            break
        }
    }
}
