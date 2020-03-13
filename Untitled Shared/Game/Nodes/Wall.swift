//
//  Wall.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 12/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Wall: SKNode {

    init(object: TiledObject) {
        super.init()
        self.position = CGPoint(x: object.x + object.width / 2, y: -object.y - object.height / 2)
        if let map = TiledMap.current {
            self.position = self.position - CGPoint(x: map.tileWidth / 2, y: -map.tileHeight / 2)
        }
        self.loadPhysics(object: object)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadPhysics(object: TiledObject) {
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: object.width, height: object.height))
        physicsBody.isDynamic = false
        self.physicsBody = physicsBody
    }
}
