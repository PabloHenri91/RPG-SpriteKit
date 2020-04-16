//
//  Wall.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 12/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Wall: SKSpriteNode {

    init(object: TiledObject) {
        super.init(texture: nil, color: .clear, size: CGSize(width: object.width, height: object.height))
        self.position = CGPoint(x: object.x + object.width / 2, y: -object.y - object.height / 2)
        if let map = TiledMap.current {
            self.position = self.position - CGPoint(x: map.tileWidth / 2, y: -map.tileHeight / 2)
        }
        self.loadPhysics(width: object.width, height: object.height)
    }
    
    init?(texture: SKTexture?, x: Int, y: Int) {
        guard let map = TiledMap.current else { return nil }
        let width = map.tileWidth
        let height = map.tileHeight
        super.init(texture: texture, color: .white, size: CGSize(width: width, height: height))
        self.position = TiledTile.position(x: x, y: y)
        self.loadPhysics(width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadPhysics(width: CGFloat, height: CGFloat) {
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        physicsBody.isDynamic = false
        self.physicsBody = physicsBody
    }
}
