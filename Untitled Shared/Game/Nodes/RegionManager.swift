//
//  RegionManager.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 05/05/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class RegionManager: NSObject {
    
    var lastUpdate: TimeInterval = 0
    var loading = false
    var playerRegion = CGPoint.zero
    var loadedRegion = CGPoint.zero { didSet { self.didSetLoadedRegion() } }
    var loadedRegionList = [Int: CGPoint]()

    func updatePlayerRegion(position: CGPoint) {
        guard let map = TiledMap.current else {
            return
        }
        self.playerRegion.x = (position.x / map.size.width).rounded()
        self.playerRegion.y = (position.y / map.size.height).rounded()
    }
    
    func update(position: CGPoint) {
        
        if self.loading {
            return
        }
        
        if GameScene.currentTime - self.lastUpdate > 0.1 {
            self.lastUpdate = GameScene.currentTime
            self.updatePlayerRegion(position: position)
            if self.playerRegion != self.loadedRegion {
                self.loading = true
                self.load()
                self.loading = false
            }
        }
    }
    
    func load() {
        
    }
    
    func didSetLoadedRegion() {
        self.loadedRegionList = [
            0 : self.loadedRegion + CGPoint(x:-1, y: 1),
            1 : self.loadedRegion + CGPoint(x:0, y: 1),
            2 : self.loadedRegion + CGPoint(x:1, y: 1),
            3 : self.loadedRegion + CGPoint(x:-1, y: 0),
            4 : self.loadedRegion + CGPoint(x:0, y: 0),
            5 : self.loadedRegion + CGPoint(x:1, y: 0),
            6 : self.loadedRegion + CGPoint(x:-1, y:-1),
            7 : self.loadedRegion + CGPoint(x:0, y:-1),
            8 : self.loadedRegion + CGPoint(x:1, y:-1),
        ]
    }
}
