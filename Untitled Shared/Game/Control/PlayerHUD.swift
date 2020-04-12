//
//  PlayerHUD.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class PlayerHUD: Control {
    
    var backpackSlot: ItemSlot!
    var chestSlot: ItemSlot!
    var leftHandSlot: ItemSlot!
    var rightHandSlot: ItemSlot!

    init() {
        super.init(x: 0, y: 0)
        
        let backpackSlot = ItemSlot(x: 444, y: 234, horizontalAlignment: .right, verticalAlignment: .bottom)
        self.addChild(backpackSlot)
        self.backpackSlot = backpackSlot
        
        let chestSlot = ItemSlot(x: 444, y: 198, horizontalAlignment: .right, verticalAlignment: .bottom)
        self.addChild(chestSlot)
        self.chestSlot = chestSlot
        
        let rightHandSlot = ItemSlot(x: 10, y: 234, horizontalAlignment: .left, verticalAlignment: .bottom)
        self.addChild(rightHandSlot)
        self.rightHandSlot = rightHandSlot
        
        let leftHandSlot = ItemSlot(x: 444, y: 162, horizontalAlignment: .right, verticalAlignment: .bottom)
        self.addChild(leftHandSlot)
        self.leftHandSlot = leftHandSlot
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(playableCharacter: PlayableCharacter) {
        self.backpackSlot.addItem(item: playableCharacter.backpack)
        self.chestSlot.addItem(item: playableCharacter.armor)
        self.leftHandSlot.addItem(item: playableCharacter.shield)
        self.leftHandSlot.addItem(item: playableCharacter.arrow)
        self.rightHandSlot.addItem(item: playableCharacter.weapon)
    }
}
