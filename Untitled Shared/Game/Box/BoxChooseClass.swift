//
//  BoxChooseClass.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 08/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BoxChooseClass: Box {
    
    init(completion block: @escaping (PlayableCharacter.type) -> Void) {
        super.init(imageNamed: "box_130x118")
        
        let buttonWarrior = Button(imageNamed: "button_110x26", text: "Warrior", x: 10, y: 10)
        self.addChild(buttonWarrior)
        buttonWarrior.addHandler {
            block(.warrior)
        }
        
        let buttonMage = Button(imageNamed: "button_110x26", text: "Mage", x: 10, y: 46)
        self.addChild(buttonMage)
        buttonMage.addHandler {
            block(.mage)
        }
        
        let buttonRanger = Button(imageNamed: "button_110x26", text: "Ranger", x: 10, y: 82)
        self.addChild(buttonRanger)
        buttonRanger.addHandler {
            block(.ranger)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
