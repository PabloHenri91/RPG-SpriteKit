//
//  StatusBar.swift
//  Untitled iOS
//
//  Created by John Reis on 28/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class StatusBar: Control {
    
    var healthBar: HealthBar!
    var manaBar: ManaBar!
    
    init() {
        super.init(imageNamed: "statusbar", x: 8, y: 8, horizontalAlignment: .left, verticalAlignment: .top)
        self.loadHealthBar()
        self.loadManaBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadHealthBar() {
        self.healthBar = HealthBar()
        self.addChild(self.healthBar)
    }
    
    func loadManaBar() {
        self.manaBar = ManaBar()
        self.addChild(self.manaBar)
    }
}
