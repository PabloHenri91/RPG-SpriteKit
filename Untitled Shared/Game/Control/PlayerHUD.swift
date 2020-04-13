//
//  PlayerHUD.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class PlayerHUD: Control {
    
    weak var backpackSlot: ItemSlot!
    weak var chestSlot: ItemSlot!
    weak var leftHandSlot: ItemSlot!
    weak var rightHandSlot: ItemSlot!
    weak var backpackHUD: BackpackHUD!

    init() {
        super.init(x: 0, y: 0)
        
        let backpackSlot = ItemSlot(x: 444, y: 234, horizontalAlignment: .right, verticalAlignment: .bottom)
        self.addChild(backpackSlot)
        self.backpackSlot = backpackSlot
        backpackSlot.addHandler { [weak self] in
            guard let `self` = self else { return }
            self.backpackSlotHandler()
        }
        
        let chestSlot = ItemSlot(x: 444, y: 198, horizontalAlignment: .right, verticalAlignment: .bottom)
        self.addChild(chestSlot)
        self.chestSlot = chestSlot
        
        let rightHandSlot = ItemSlot(x: 10, y: 234, horizontalAlignment: .left, verticalAlignment: .bottom)
        self.addChild(rightHandSlot)
        self.rightHandSlot = rightHandSlot
        
        let leftHandSlot = ItemSlot(x: 444, y: 162, horizontalAlignment: .right, verticalAlignment: .bottom)
        self.addChild(leftHandSlot)
        self.leftHandSlot = leftHandSlot
        
        let backpackHUD = BackpackHUD(x: 44, y: 43, horizontalAlignment: .center, verticalAlignment: .center)
        backpackHUD.isHidden = true
        self.addChild(backpackHUD)
        self.backpackHUD = backpackHUD
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func canForceCenterVerticalAlignment() -> Bool {
        return false
    }
    
    func configure(playableCharacter: PlayableCharacter) {
        self.backpackSlot.addItem(item: playableCharacter.backpack)
        self.chestSlot.addItem(item: playableCharacter.armor)
        self.leftHandSlot.addItem(item: playableCharacter.shield)
        self.leftHandSlot.addItem(item: playableCharacter.arrow)
        self.rightHandSlot.addItem(item: playableCharacter.weapon)
        self.backpackHUD.configure(backpack: playableCharacter.backpack)
    }
    
    func backpackSlotHandler() {
        if let _ = self.backpackSlot.item {
            self.backpackHUD.isHidden = !self.backpackHUD.isHidden
        }
    }
}
