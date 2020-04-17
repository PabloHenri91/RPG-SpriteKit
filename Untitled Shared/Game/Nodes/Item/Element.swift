//
//  Element.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 09/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class Element: NSObject {
    
    enum type: String {
        case none
        case fire
        case ice
        case wind
        case earth
        case thunder
        case water
        case light
        case darkness
    }

    var type: type
    var strength: type
    var weakness: type
    var color: SKColor
    
    static var types: [type: Element] = [
        .fire: Element(type: .fire, strength: .ice, weakness: .water),
        .ice: Element(type: .ice, strength: .wind, weakness: .fire),
        .wind: Element(type: .wind, strength: .earth, weakness: .ice),
        .earth: Element(type: .earth, strength: .thunder, weakness: .wind),
        .thunder: Element(type: .thunder, strength: .water, weakness: .earth),
        .water: Element(type: .water, strength: .fire, weakness: .thunder),
        .light: Element(type: .light, strength: .light, weakness: .darkness),
        .darkness: Element(type: .darkness, strength: .darkness, weakness: .light)
    ]
    
    init(type: type, strength: type, weakness: type) {
        
        self.type = type
        self.strength = strength
        self.weakness = weakness
        
        var elementColor = GameColors.darkness
        
        switch type {
        case .fire:
            elementColor = GameColors.fire
            break
        case .ice:
            elementColor = GameColors.ice
            break
        case .wind:
            elementColor = GameColors.wind
            break
        case .earth:
            elementColor = GameColors.earth
            break
        case .thunder:
            elementColor = GameColors.thunder
            break
        case .water:
            elementColor = GameColors.water
            break
        case .light:
            elementColor = GameColors.light
            break
        case .darkness:
            elementColor = GameColors.darkness
            break
        default:
            break
        }
        
        self.color = elementColor
    }
    
    static func color(color: SKColor) -> SKColor {
        
        var elementColor = GameColors.darkness
        
        switch element(color: color).type {
        case .fire:
            elementColor = GameColors.fire
            break
        case .ice:
            elementColor = GameColors.ice
            break
        case .wind:
            elementColor = GameColors.wind
            break
        case .earth:
            elementColor = GameColors.earth
            break
        case .thunder:
            elementColor = GameColors.thunder
            break
        case .water:
            elementColor = GameColors.water
            break
        case .light:
            elementColor = GameColors.light
            break
        case .darkness:
            elementColor = GameColors.darkness
            break
        default:
            break
        }
        
        return elementColor
    }
    
    static func randomColor() -> SKColor {
        var red = CGFloat.random()
        var green = CGFloat.random()
        var blue = CGFloat.random()
        
        let color = SKColor(red: red, green: green, blue: blue, alpha: 1)
        let element = Element.element(color: color)
        
        let elementColor: CIColor = element.color.ciColor()
        
        red = (red + elementColor.red) / 2
        green = (green + elementColor.green) / 2
        blue = (blue + elementColor.blue) / 2
        
        if element.type != .darkness {
            let maxColor = 1 - max(max(red, green), blue)
            red = red + maxColor
            green = green + maxColor
            blue = blue + maxColor
        }
        
        return SKColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func randomColor(type: Element.type) -> SKColor {
        let color = Element.randomColor()
        if Element.element(color: color).type == type {
            return color
        } else {
            return Element.randomColor(type: type)
        }
    }
    
    static func element(color: SKColor) -> Element {
        
        let color: CIColor = color.ciColor()
        
        let red  = color.red
        let green = color.green
        let blue = color.blue
        
        var element: Element? = Element.types[.darkness]
        
        switch (red > 0.5, green > 0.5, blue > 0.5) {
            
        case (true, false, false):
            element = Element.types[.fire]
            break
        case (false, true, false):
            element = Element.types[.earth]
            break
        case (false, false, true):
            element = Element.types[.water]
            break
            
        case (false, true, true):
            element = Element.types[.ice]
            break
        case (true, false, true):
            element = Element.types[.thunder]
            break
        case (true, true, false):
            element = Element.types[.wind]
            break
            
        case (true, true, true):
            element = Element.types[.light]
            break
        case (false, false, false):
            element = Element.types[.darkness]
            break
        }
        
        return element!
    }
    
    static func randomElement() -> Element {
        return Element.element(color: Element.randomColor())
    }
    
    static func none() -> Element {
        return Element(type: .none, strength: .none, weakness: .none)
    }
    
    override var description: String {
        switch self.type {
        case .none:
            return "null"
        case .fire:
            return "Fire"
        case .ice:
            return "Ice"
        case .wind:
            return "Wind"
        case .earth:
            return "Earth"
        case .thunder:
            return "Thunder"
        case .water:
            return "Water"
        case .light:
            return "Light"
        case .darkness:
            return "Darkness"
        }
    }
}
