//
//  BoxChooseAttribute.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 08/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BoxChooseAttribute: Box {
    
    init(completion block: @escaping (PlayableCharacter.attribute) -> Void) {
        super.init(imageNamed: "box_130x226")
        
        let button0 = Button(imageNamed: "button_110x26", text: "Constitution", x: 10, y: 10)
        self.addChild(button0)
        button0.addHandler {
            block(.constitution)
        }
        
        let button1 = Button(imageNamed: "button_110x26", text: "Strength", x: 10, y: 46)
        self.addChild(button1)
        button1.addHandler {
            block(.strength)
        }
        
        let button2 = Button(imageNamed: "button_110x26", text: "Agility", x: 10, y: 82)
        self.addChild(button2)
        button2.addHandler {
            block(.agility)
        }
        
        let button3 = Button(imageNamed: "button_110x26", text: "Dexterity", x: 10, y: 118)
        self.addChild(button3)
        button3.addHandler {
            block(.dexterity)
        }
        
        let button4 = Button(imageNamed: "button_110x26", text: "Wisdom", x: 10, y: 154)
        self.addChild(button4)
        button4.addHandler {
            block(.wisdom)
        }
        
        let button5 = Button(imageNamed: "button_110x26", text: "Intelligence", x: 10, y: 190)
        self.addChild(button5)
        button5.addHandler {
            block(.intelligence)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
