//
//  NonPlayableCharacter.swift
//  Untitled iOS
//
//  Created by John Reis on 26/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class NonPlayableCharacter: SKSpriteNode {
    
    // Movement
    var actionMoveA = SKAction()
    var actionMoveS = SKAction()
    var actionMoveD = SKAction()
    var actionMoveW = SKAction()
    
    var isMoving = false
    
    enum moveType {
        case none
        case moveA
        case moveS
        case moveD
        case moveW
    }
    
    var lastMove: moveType = .none
    
    var destination: CGPoint? = nil
    
    // Controls
    var moveA = false
    var moveS = false
    var moveD = false
    var moveW = false
    
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    
    weak var nodePhysicsBody: SKPhysicsBody?
    
    init() {
        super.init(texture: nil, color: SKColor.white, size: CGSize(width: 1, height: 1))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func configure(mapManager: MapManager) {
        if let map = TiledMap.current ?? mapManager.chunks.first {
            self.tileWidth = map.tileWidth
            self.tileHeight = map.tileHeight
            self.loadPhysics()
            self.loadActions()
            self.loadTexture()
            return
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update() {
        
    }
    
    func loadPhysics() {
        
        var transform = CGAffineTransform(rotationAngle: π/4)
        
        let physicsBody = SKPhysicsBody(polygonFrom: CGPath(rect: CGRect(x: -self.tileWidth/2, y: -self.tileHeight/2, width: self.tileWidth, height: self.tileHeight), transform: &transform))
        
        physicsBody.usesPreciseCollisionDetection = false
        physicsBody.categoryBitMask = UInt32.max
        physicsBody.collisionBitMask = 0
        physicsBody.contactTestBitMask = UInt32.max
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        
        let node = SKNode()
        node.physicsBody = physicsBody
        self.addChild(node)
        self.nodePhysicsBody = physicsBody
    }
    
    func loadActions() {
        
        let speed: Double = 960
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
    
    func loadTexture() {
        
        for node in self.children {
            if node is SKSpriteNode {
                node.removeFromParent()
            }
        }
        
        var tileset = TiledTileset.load(imageNamed: "bodyTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
        self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
        
        tileset = TiledTileset.load(imageNamed: "armorTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
        self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
        
        tileset = TiledTileset.load(imageNamed: "legsTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
        self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
        
        tileset = TiledTileset.load(imageNamed: "hairTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
        self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
        
        tileset = TiledTileset.load(imageNamed: "headTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
        self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
        
        switch Float.random(in: 0...2).rounded()  {
        case 0:
            tileset = TiledTileset.load(imageNamed: "meleeTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
            self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
            
            tileset = TiledTileset.load(imageNamed: "shieldTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
            self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
            break
        case 1:
            tileset = TiledTileset.load(imageNamed: "rangedTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
            self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
            break
        case 2:
            tileset = TiledTileset.load(imageNamed: "magicTileset", tileWidth: self.tileWidth, tileHeight: self.tileHeight)
            self.addChild(SKSpriteNode(texture: tileset.tileTextures.randomElement()))
            break
        default:
            break
        }
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
        
        if let contactedBodies = self.nodePhysicsBody?.allContactedBodies() {
            for physicsBody in contactedBodies {
                if let node = physicsBody.node as? SKSpriteNode {
                    
                    let offset = CGPoint(x: node.size.width / 2, y: node.size.height / 2)
                    let nodePosition = (node.parent ?? node).convert(node.position, to: self.parent ?? self) - offset
                    
                    if moveDirectionX != 0 {
                        let position = self.position + CGPoint(x: moveDirectionX * self.tileWidth, y: 0)
                        if CGRect(origin: nodePosition, size: node.size).contains(position) {
                            moveDirectionX = 0
                        }
                    }
                    
                    if moveDirectionY != 0 {
                        let position = self.position + CGPoint(x: 0, y: moveDirectionY * self.tileHeight)
                        if CGRect(origin: nodePosition, size: node.size).contains(position) {
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
            case .none:
                break
            }
        }
        
        if moveDirectionX != 0 {
            if moveDirectionX > 0 {
                if self.lastMove != .moveA {
                    self.lastMove = .moveD
                    self.isMoving = true
                    self.run(self.actionMoveD)
                }
            } else {
                if self.lastMove != .moveD {
                    self.lastMove = .moveA
                    self.isMoving = true
                    self.run(self.actionMoveA)
                }
            }
        } else {
            if moveDirectionY != 0 {
                if moveDirectionY > 0 {
                    if self.lastMove != .moveS {
                        self.lastMove = .moveW
                        self.isMoving = true
                        self.run(self.actionMoveW)
                    }
                } else {
                    if self.lastMove != .moveW {
                        self.lastMove = .moveS
                        self.isMoving = true
                        self.run(self.actionMoveS)
                    }
                }
            }
        }
        
        self.moveA = false
        self.moveS = false
        self.moveD = false
        self.moveW = false
    }
}
