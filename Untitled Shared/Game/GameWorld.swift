//
//  GameWorld.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class GameWorld: SKNode, SKPhysicsContactDelegate {

    static func current() -> GameWorld? {
        return GameWorld.lastInstance
    }
    private static weak var lastInstance: GameWorld? = nil
    
    override init() {
        super.init()
        GameWorld.lastInstance = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        
        switch categoryBitMask(rawValue: bodyA.categoryBitMask | bodyB.categoryBitMask) {
            default:
            #if DEBUG
                var bodyAcategoryBitMask = ""
                var bodyBcategoryBitMask = ""
                switch bodyA.categoryBitMask {
                case categoryBitMask.categoryBitMaskA.rawValue:
                    bodyAcategoryBitMask = "categoryBitMaskA"
                    break
                case categoryBitMask.categoryBitMaskB.rawValue:
                    bodyAcategoryBitMask = "categoryBitMaskB"
                    break
                case categoryBitMask.categoryBitMaskC.rawValue:
                    bodyAcategoryBitMask = "categoryBitMaskC"
                    break
                default:
                    bodyAcategoryBitMask = "unknown"
                    break
                }
                switch bodyB.categoryBitMask {
                    case categoryBitMask.categoryBitMaskA.rawValue:
                        bodyBcategoryBitMask = "categoryBitMaskA"
                        break
                    case categoryBitMask.categoryBitMaskB.rawValue:
                        bodyBcategoryBitMask = "categoryBitMaskB"
                        break
                    case categoryBitMask.categoryBitMaskC.rawValue:
                        bodyBcategoryBitMask = "categoryBitMaskC"
                        break
                default:
                    bodyBcategoryBitMask = "unknown"
                    break
                }
                print("\(#function) case [.\(bodyAcategoryBitMask), .\(bodyBcategoryBitMask)]:")
                fatalError()
            #endif
            break
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        
        switch categoryBitMask(rawValue: bodyA.categoryBitMask | bodyB.categoryBitMask) {
        default:
            #if DEBUG
                var bodyAcategoryBitMask = ""
                var bodyBcategoryBitMask = ""
                switch bodyA.categoryBitMask {
                case categoryBitMask.categoryBitMaskA.rawValue:
                    bodyAcategoryBitMask = "categoryBitMaskA"
                    break
                case categoryBitMask.categoryBitMaskB.rawValue:
                    bodyAcategoryBitMask = "categoryBitMaskB"
                    break
                case categoryBitMask.categoryBitMaskC.rawValue:
                    bodyAcategoryBitMask = "categoryBitMaskC"
                    break
                default:
                    bodyAcategoryBitMask = "unknown"
                    break
                }
                switch bodyB.categoryBitMask {
                    case categoryBitMask.categoryBitMaskA.rawValue:
                        bodyBcategoryBitMask = "categoryBitMaskA"
                        break
                    case categoryBitMask.categoryBitMaskB.rawValue:
                        bodyBcategoryBitMask = "categoryBitMaskB"
                        break
                    case categoryBitMask.categoryBitMaskC.rawValue:
                        bodyBcategoryBitMask = "categoryBitMaskC"
                        break
                default:
                    bodyBcategoryBitMask = "unknown"
                    break
                }
                print("\(#function) case [.\(bodyAcategoryBitMask), .\(bodyBcategoryBitMask)]:")
                fatalError()
            #endif
            break
        }
    }
    
    struct categoryBitMask: OptionSet {
        let rawValue: UInt32
        
        static let categoryBitMaskA =   categoryBitMask(rawValue: 1 << 0)
        static let categoryBitMaskB =   categoryBitMask(rawValue: 1 << 1)
        static let categoryBitMaskC =   categoryBitMask(rawValue: 1 << 2)
    }
    
    struct collisionBitMask {
        
        static let categoryBitMaskA: categoryBitMask = [.categoryBitMaskA, .categoryBitMaskB, .categoryBitMaskC]
        static let categoryBitMaskB: categoryBitMask = [.categoryBitMaskA, .categoryBitMaskB, .categoryBitMaskC]
        static let categoryBitMaskC: categoryBitMask = [.categoryBitMaskA, .categoryBitMaskB, .categoryBitMaskC]
    }
    
    struct contactTestBitMask {
        
        static let categoryBitMaskA: categoryBitMask = [.categoryBitMaskA, .categoryBitMaskB, .categoryBitMaskC]
        static let categoryBitMaskB: categoryBitMask = [.categoryBitMaskA, .categoryBitMaskB, .categoryBitMaskC]
        static let categoryBitMaskC: categoryBitMask = [.categoryBitMaskA, .categoryBitMaskB, .categoryBitMaskC]
    }
}
