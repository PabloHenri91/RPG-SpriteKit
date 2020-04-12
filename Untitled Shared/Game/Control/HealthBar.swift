//
//  HealthBar.swift
//  Untitled iOS
//
//  Created by John Reis on 28/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class HealthBar: BaseBar {

    init() {
        super.init(imageNamed: "healthBar")
        self.position = CGPoint(x: 28, y: -4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
