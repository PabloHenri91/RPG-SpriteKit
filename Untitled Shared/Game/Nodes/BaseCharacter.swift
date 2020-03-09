//
//  BaseCharacter.swift
//  Untitled iOS
//
//  Created by John Reis on 26/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BaseCharacter: SKSpriteNode {
    
    var statusBar: StatusBar!
    
    var maxHealth: CGFloat = 0
    var maxMana: CGFloat = 0
    var mana: CGFloat = 0
    var health: CGFloat = 0
    
    var level = 1
    
    // Movement
    var actionMoveA = SKAction()
    var actionMoveS = SKAction()
    var actionMoveD = SKAction()
    var actionMoveW = SKAction()
    
    var isMoving = false
    
    enum moveType {
        case moveA
        case moveS
        case moveD
        case moveW
    }
    
    var lastMove: moveType = .moveS
    
    var destination: CGPoint? = nil
    
    // Controls
    var moveA = false
    var moveS = false
    var moveD = false
    var moveW = false
    
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    
    init(textureName: String = "Player0") {
        
        let texture = SKTexture(imageNamed: textureName, filteringMode: GameScene.defaultFilteringMode)
        
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func configure(mapManager: MapManager) {
        if let map = TiledMap.current ?? mapManager.chunks.first {
            self.tileWidth = map.tileWidth
            self.tileHeight = map.tileHeight
            self.loadActions()
            return
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update() {
        
    }
    
    func loadActions() {
        
        let speed: Double = 1280
        let distance: Double = Double(self.tileWidth)
        
        let moveActionDuration: TimeInterval = distance/speed
        
        self.actionMoveA = SKAction.group([
            SKAction.sequence([
                SKAction.moveBy(x: -1 * self.tileWidth, y: 0, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
            ])
        ])
        
        self.actionMoveS = SKAction.group([
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: -1 * self.tileHeight, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
            ])
        ])
        
        self.actionMoveD = SKAction.group([
            SKAction.sequence([
                SKAction.moveBy(x: 1 * self.tileWidth, y: 0, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
            ])
        ])
        
        self.actionMoveW = SKAction.group([
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: 1 * self.tileHeight, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
            ])
        ])
    }
    
    func move() {
        
        if self.isMoving {
            return
        }
        
        var moveDirectionX: CGFloat = 0
        var moveDirectionY: CGFloat = 0
        
        if self.moveA {
            moveDirectionX = moveDirectionX - 1
        }
        if self.moveS {
            moveDirectionY = moveDirectionY - 1
        }
        if self.moveD {
            moveDirectionX = moveDirectionX + 1
        }
        if self.moveW {
            moveDirectionY = moveDirectionY + 1
        }
        
        if let contactedBodies = self.physicsBody?.allContactedBodies() {
            for physicsBody in contactedBodies {
                if let node = physicsBody.node {
                    
                    let delta = node.position - self.position
                    
                    if delta.x > self.tileWidth/2 {
                        if moveDirectionX > 0 {
                            moveDirectionX = 0
                        }
                    }
                    
                    if delta.x < -self.tileWidth/2 {
                        if moveDirectionX < 0 {
                            moveDirectionX = 0
                        }
                    }
                    
                    if delta.y > self.tileHeight/2 {
                        if moveDirectionY > 0 {
                            moveDirectionY = 0
                        }
                    }
                    
                    if delta.y < -self.tileHeight/2 {
                        if moveDirectionY < 0 {
                            moveDirectionY = 0
                        }
                    }
                }
            }
        }
        
        if moveDirectionX != 0 && moveDirectionY != 0 {
            switch self.lastMove {
                case .moveA, .moveD:
                    moveDirectionX = 0
                    break
                case .moveS, .moveW:
                    moveDirectionY = 0
                    break
            }
        }
        
        if moveDirectionX != 0 {
            self.isMoving = true
            
            if moveDirectionX > 0 {
                self.lastMove = .moveD
                self.run(self.actionMoveD)
            } else {
                self.lastMove = .moveA
                self.run(self.actionMoveA)
            }
            
        } else {
            if moveDirectionY != 0 {
                self.isMoving = true
                
                if moveDirectionY > 0 {
                    self.lastMove = .moveW
                    self.run(self.actionMoveW)
                } else {
                    self.lastMove = .moveS
                    self.run(self.actionMoveS)
                }
            }
        }
        
        self.moveA = false
        self.moveS = false
        self.moveD = false
        self.moveW = false
    }
    
    func die() {
        print("died")
    }
    
    func updateMana(with value: CGFloat) {
        self.mana += value
        self.statusBar.manaBar.update(with: self.mana, from: self.maxMana)
    }
    
    func updateHealth(with value: CGFloat) {
        self.health += value
        
        self.statusBar.healthBar.update(with: self.health, from: self.maxHealth)
        
        if health <= 0 {
            return self.die()
        }
    }
}
