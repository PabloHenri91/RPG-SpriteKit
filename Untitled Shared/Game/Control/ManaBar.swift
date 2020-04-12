//
//  HealthBar.swift
//  Untitled iOS
//
//  Created by John Reis on 28/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class ManaBar: BaseBar {
    init() {
        super.init(imageNamed: "manaBar")
        self.position = CGPoint(x: 28, y: -13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
