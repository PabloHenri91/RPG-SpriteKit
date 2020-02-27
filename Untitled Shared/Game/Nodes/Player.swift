//
//  Player.swift
//  Untitled iOS
//
//  Created by John Reis on 26/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Player: BaseCharacter {
    
    override init() {
        super.init(textureName: "Player0")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update() {
        self.move()
    }
    
    override func move() {
        if let destination = self.destination {
            
            self.moveA = false
            self.moveS = false
            self.moveD = false
            self.moveW = false
            
            if self.position.distanceTo(destination) < 1 {
                self.destination = nil
            } else {
                let delta = destination - self.position
                
                if abs(delta.x) > TiledMap.tileWidth {
                    if delta.x > 0 {
                        self.moveD = true
                    } else {
                        self.moveA = true
                    }
                }
                
                if abs(delta.y) > TiledMap.tileHeight {
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
}