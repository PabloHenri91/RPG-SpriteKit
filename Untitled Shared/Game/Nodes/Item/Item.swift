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
    
    init(level: Int = 0, rarity: rarity = .common, color: SKColor? = nil, skin: Int = 0) {
        self.level = level
        self.rarity = rarity
        self.skin = skin
        super.init(texture: nil, color: color ?? Element.randomColor(), size: CGSize.zero)
        self.load()
    }
    
    convenience init(itemData: ItemData) {
        let level = Int(itemData.level)
        let rarity = Item.rarity(rawValue: Int(itemData.rarity)) ?? .common
        let color = SKColor(red: CGFloat(itemData.colorRed), green: CGFloat(itemData.colorGreen), blue: CGFloat(itemData.colorBlue), alpha: 1)
        let skin = Int(itemData.skin)
        self.init(level: level, rarity: rarity, color: color, skin: skin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
