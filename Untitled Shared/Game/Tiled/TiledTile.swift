//
//  TiledTile.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class TiledTile: SKSpriteNode {

    init(texture: SKTexture, x: Int, y: Int) {
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        self.position = TiledTile.position(x: x, y: y)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func position(x: Int, y: Int) -> CGPoint {
        return CGPoint(x: x * Int(TiledMap.tileWidth) - Int(TiledMap.size.width)/2 + Int(TiledMap.tileWidth/2),
                       y: -y * Int(TiledMap.tileHeight) + Int(TiledMap.size.height)/2 - Int(TiledMap.tileHeight/2))
    }
}
