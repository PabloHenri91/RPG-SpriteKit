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
        guard let tiledMap = TiledMap.current else {
            return
        }
        
        if let destination = self.destination {
            
            self.moveA = false
            self.moveS = false
            self.moveD = false
            self.moveW = false
            
            if self.position.distanceTo(destination) < 1 {
                self.destination = nil
            } else {
                let delta = destination - self.position
                
                if abs(delta.x) > tiledMap.tileWidth/2 {
                    if delta.x > 0 {
                        self.moveD = true
                    } else {
                        self.moveA = true
                    }
                }
                
                if abs(delta.y) > tiledMap.tileHeight/2 {
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
                    x: ((touchLocation.x - TiledMap.tileWidth/2) / TiledMap.tileWidth).rounded() * TiledMap.tileWidth + TiledMap.tileWidth/2,
                    y: ((touchLocation.y - TiledMap.tileHeight/2) / TiledMap.tileHeight).rounded() * TiledMap.tileHeight + TiledMap.tileHeight/2)
                
                self.destination = touchLocation
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        self.updateHealth(with: -20)
    }
}
