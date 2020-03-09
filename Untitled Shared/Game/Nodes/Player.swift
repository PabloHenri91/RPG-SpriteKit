//
//  Player.swift
//  Untitled iOS
//
//  Created by John Reis on 26/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Player: BaseCharacter {

    init() {
        super.init(textureName: "Player0")
        self.maxMana = 300
        self.mana = 300
        
        self.maxHealth = 500
        self.health = 500
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
            
            if self.position.distanceTo(destination) < 1 {
                self.destination = nil
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
            } else {
                touchLocation = CGPoint(
                    x: ((touchLocation.x) / TiledMap.tileWidth).rounded() * TiledMap.tileWidth,
                    y: ((touchLocation.y) / TiledMap.tileHeight).rounded() * TiledMap.tileHeight)
                
                self.destination = touchLocation
            }
        }
    }
    
    override func die() {
        super.die()
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0, 123:
            self.moveA = true
            break
        case 1, 125:
            self.moveS = true
            break
        case 2, 124:
            self.moveD = true
            break
        case 13, 126:
            self.moveW = true
            break
        default:
            break
        }
        
        self.updateHealth(with: -20)
        self.updateMana(with: -20)
    }
}
