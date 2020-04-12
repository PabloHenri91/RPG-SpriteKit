//
//  ItemSlot.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 12/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class ItemSlot: Control {
    
    var item: Item? = nil

    init(x: CGFloat, y: CGFloat, horizontalAlignment: Control.horizontalAlignment = .left, verticalAlignment: Control.verticalAlignment = .top) {
        super.init(imageNamed: "itemBox", x: x, y: y, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @discardableResult
    func addItem(item: Item?) -> Item? {
        guard let item = item else { return nil }
        let itemToDrop = self.item
        self.configure(item: item)
        self.item = item
        return itemToDrop
    }
    
    func configure(item: Item) {
        let icon = item.icon()
        icon.position = CGPoint(x: self.size.width / 2, y: -self.size.height / 2)
        self.addChild(icon)
    }
}
