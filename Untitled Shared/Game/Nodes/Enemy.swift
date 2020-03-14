//
//  Enemy.swift
//  RPG-SpriteKit
//
//  Created by John Reis on 09/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Enemy: BaseCharacter {

    static var enemyList = Set<Enemy>()
    
    override func die() {
        super.die()
        Enemy.enemyList.remove(self)
        self.removeFromParent()
    }
    
}
