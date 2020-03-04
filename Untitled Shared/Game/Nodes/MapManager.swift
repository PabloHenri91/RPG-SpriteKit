//
//  MapManager.swift
//  Untitled iOS
//
//  Created by John Reis on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class MapManager: NSObject {
    
    var lastUpdate: TimeInterval = 0
    var loading = false
    
    var playerRegion = CGPoint.zero
    var loadedRegion = CGPoint.zero
    
    var chunks = [TiledMap]()
    
    var mapType = "world"
    
    func reload() {
        
        for chunk in self.chunks {
            chunk.destroy()
        }
        
        for y in [self.playerRegion.y - 1, self.playerRegion.y, self.playerRegion.y + 1] {
            for x in [self.playerRegion.x - 1, self.playerRegion.x, self.playerRegion.x + 1] {
                let filename = "\(self.mapType)"
                let chunk = TiledMap(fileNamed: "\(filename)_\(Int(x))_\(Int(y))", x: x, y: y)
                self.chunks.append(chunk)
            }
        }
        
        self.addTiledMaps();
        
        self.loadedRegion = self.playerRegion
    }
    
    func addTiledMaps() {
        guard let gameWorld = GameWorld.current else { return }
        for chunk in self.chunks {
            if chunk.parent == nil {
                gameWorld.addChild(chunk)
            }
        }
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
                self.loadMap()
                self.loading = false
            }
        }
    }
    
    func updatePlayerRegion(position: CGPoint) {
        guard let map = TiledMap.current else {
            return
        }
        self.playerRegion.x = (position.x / map.size.width).rounded()
        self.playerRegion.y = (position.y / map.size.height).rounded()
    }
    
    func loadMap() {
        
        if self.playerRegion.x < self.loadedRegion.x {
            self.loadedRegion.x = self.loadedRegion.x - 1;
            self.loadA()
            return
        }
        
        if self.playerRegion.y > self.loadedRegion.y {
            self.loadedRegion.y = self.loadedRegion.y + 1;
            self.loadS()
            return
        }
        
        if self.playerRegion.x > self.loadedRegion.x {
            self.loadedRegion.x = self.loadedRegion.x + 1;
            self.loadD()
            return
        }
        
        if self.playerRegion.y < self.loadedRegion.y {
            self.loadedRegion.y = self.loadedRegion.y - 1;
            self.loadW()
            return
        }
    }
    
    func loadA() {
        self.chunks[2].destroy();
        self.chunks[5].destroy();
        self.chunks[8].destroy();

        self.chunks[2] = self.chunks[1];
        self.chunks[5] = self.chunks[4];
        self.chunks[8] = self.chunks[7];

        self.chunks[1] = self.chunks[0];
        self.chunks[4] = self.chunks[3];
        self.chunks[7] = self.chunks[6];

        self.chunks[0] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x - 1, y: loadedRegion.y - 1)
        self.chunks[3] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x - 1, y: loadedRegion.y + 0)
        self.chunks[6] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x - 1, y: loadedRegion.y + 1)

        self.addTiledMaps();
    }
    
    func loadS() {
        self.chunks[0].destroy();
        self.chunks[1].destroy();
        self.chunks[2].destroy();

        self.chunks[0] = self.chunks[3];
        self.chunks[1] = self.chunks[4];
        self.chunks[2] = self.chunks[5];

        self.chunks[3] = self.chunks[6];
        self.chunks[4] = self.chunks[7];
        self.chunks[5] = self.chunks[8];

        self.chunks[6] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x - 1, y: self.loadedRegion.y + 1)
        self.chunks[7] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 0, y: self.loadedRegion.y + 1)
        self.chunks[8] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 1, y: self.loadedRegion.y + 1)

        self.addTiledMaps();
    }
    
    func loadD() {
        self.chunks[0].destroy()
        self.chunks[3].destroy()
        self.chunks[6].destroy()
        
        self.chunks[0] = self.chunks[1]
        self.chunks[3] = self.chunks[4]
        self.chunks[6] = self.chunks[7]
        
        self.chunks[1] = self.chunks[2]
        self.chunks[4] = self.chunks[5]
        self.chunks[7] = self.chunks[8]
        
        self.chunks[2] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 1, y: self.loadedRegion.y + 1)
        self.chunks[5] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 1, y: self.loadedRegion.y + 0)
        self.chunks[8] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 1, y: self.loadedRegion.y - 1)
        
        self.addTiledMaps()
    }
    
    func loadW() {
        self.chunks[6].destroy()
        self.chunks[7].destroy()
        self.chunks[8].destroy()
        
        self.chunks[6] = self.chunks[3]
        self.chunks[7] = self.chunks[4]
        self.chunks[8] = self.chunks[5]
        
        self.chunks[3] = self.chunks[0]
        self.chunks[4] = self.chunks[1]
        self.chunks[5] = self.chunks[2]
        
        self.chunks[0] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x - 1, y: self.loadedRegion.y + 1)
        self.chunks[1] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 0, y: self.loadedRegion.y + 1)
        self.chunks[2] = TiledMap(fileNamed: "\(self.mapType)", x: self.loadedRegion.x + 1, y: self.loadedRegion.y + 1)
        
        self.addTiledMaps()
    }
}
