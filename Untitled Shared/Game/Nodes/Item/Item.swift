//
//  Item.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 23/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Item: SKSpriteNode {

    enum rarity: Int {
        case common
        case uncommon
        case rare
        case heroic
        case epic
        case legendary
        case supreme
    }
    
    var level = 1
    var rarity: rarity = .common
    var skin = 0
    var element: Element = Element.none()
    
    static var diameter: CGFloat = 16
    
    init(level: Int = 1, rarity: rarity = .common, color: SKColor? = nil, skin: Int = 0) {
        self.level = level
        self.rarity = rarity
        let color = color ?? Element.randomColor()
        self.skin = skin
        super.init(texture: nil, color: color, size: CGSize.zero)
        self.load()
    }
    
    init?(itemData: ItemData?) {
        guard let itemData = itemData else { return nil }
        self.level = Int(itemData.level)
        self.rarity = Item.rarity(rawValue: Int(itemData.rarity)) ?? .common
        let color = itemData.color()
        self.skin = Int(itemData.skin)
        super.init(texture: nil, color: color, size: CGSize.zero)
        self.load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func icon() -> SKSpriteNode {
        let icon = SKSpriteNode(texture: self.skinTexture(skin: self.skin), color: self.color, size: self.size)
        icon.blendMode = .add
        icon.colorBlendFactor = 1
        return icon
    }
    
    func skinTexture(skin: Int) -> SKTexture {
        return SKTexture(imageNamed: "itemNull", filteringMode: GameScene.defaultFilteringMode)
    }
    
    func loadTexture(texture: SKTexture) {
        self.texture = texture
        self.size = texture.size()
        self.setScaleToFit(width: Item.diameter, height: Item.diameter)
    }
    
    private func load() {
        self.element = Element.element(color: self.color)
        let texture = self.skinTexture(skin: self.skin)
        self.loadTexture(texture: texture)
    }
    
    static func randomRarity() -> rarity {
        let n: CGFloat = CGFloat.random()
        var i: CGFloat = 1.0 / 2.0
        
        let rarities: [rarity] = [.uncommon, .rare, .epic, .legendary, .supreme]
        var value: rarity = .common
        
        for r in rarities {
            if n < i {
                i = i / 2.0
                value = r
            }
        }
        return value
    }
    
    static func description(rarity: rarity) -> String {
        switch rarity {
        case .common:
            return "Common"
        case .uncommon:
            return "Uncommon"
        case .rare:
            return "Rare"
        case .heroic:
            return "Heroic"
        case .epic:
            return "Epic"
        case .legendary:
            return "Legendary"
        case .supreme:
            return "Supreme"
        }
    }
}
