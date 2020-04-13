//
//  BackpackHUD.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class BackpackHUD: Control {
    
    var itemSlotList = [ItemSlot]()
    
    init(x: CGFloat, y: CGFloat, horizontalAlignment: Control.horizontalAlignment = .left, verticalAlignment: Control.verticalAlignment = .top) {
        super.init(x: x, y: y, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
        
        self.zPosition = GameScene.zPosition.backpackHUD
        
        for y in 0..<7 {
            for x in 0..<15 {
                let itemSlot = ItemSlot(x: CGFloat(1 + x * 26), y: CGFloat(1 + y * 26))
                self.addChild(itemSlot)
                self.itemSlotList.append(itemSlot)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(backpack: Backpack?) {
        guard let backpack = backpack else { return }
        
        for (i, item) in backpack.itemList.enumerated() {
            if i >= self.itemSlotList.count {
                return
            }
            let itemSlot = self.itemSlotList[i]
            itemSlot.addItem(item: item)
        }
    }
}
