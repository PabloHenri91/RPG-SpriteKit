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
        super.init(background: "barBackground388x10", border: "barBorder388x10", x: 0, y: 16, color: GameColors.controlBlue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
