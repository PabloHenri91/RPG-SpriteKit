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
    
    var baseRegionList = [
        0 : CGPoint(x:-1, y: 1),
        1 : CGPoint(x:0, y: 1),
        2 : CGPoint(x:1, y: 1),
        3 : CGPoint(x:-1, y: 0),
        4 : CGPoint(x:0, y: 0),
        5 : CGPoint(x:1, y: 0),
        6 : CGPoint(x:-1, y:-1),
        7 : CGPoint(x:0, y:-1),
        8 : CGPoint(x:1, y:-1),
    ]
    
    var loadedRegionList = [Int: CGPoint]()
    
    var loadedRegion = CGPoint.zero {
        didSet {
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
    
    var playerRegion = CGPoint.zero
    
    var chunks = [TiledMap]()
    
    var mapType = "world"
    
    func reload(position: CGPoint) {
        
        self.updatePlayerRegion(position: position)
        self.loadedRegion = self.playerRegion
        
        for chunk in self.chunks {
            chunk.destroy()
        }
        
        var i = 0
        for y in [self.playerRegion.y - 1, self.playerRegion.y, self.playerRegion.y + 1] {
            for x in [self.playerRegion.x - 1, self.playerRegion.x, self.playerRegion.x + 1] {
                let filename = "\(self.mapType)"
                let chunk = TiledMap(fileNamed: "\(filename)_\(Int(x))_\(Int(y))", position: self.loadedRegionList[i])
                i = i + 1
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
                print(self.playerRegion)
                self.loading = false
            }
        }
    }
    
    func updatePlayerRegion(position: CGPoint) {
        guard let map = TiledMap.current else {
            return
        }
        
        //if abs(position.x) > map.tileWidth {
            self.playerRegion.x = CGFloat(Int((position.x / map.size.width).rounded()))
        //}
        
        //if abs(position.y) > map.tileHeight {
            self.playerRegion.y = CGFloat(Int((position.y / map.size.height).rounded()))
        //}
    }
    
    func loadMap() {
        
        if self.playerRegion.x < self.loadedRegion.x {
            self.loadedRegion.x = self.loadedRegion.x - 1;
            self.loadA()
            return
        }
        
        if self.playerRegion.y > self.loadedRegion.y {
            self.loadedRegion.y = self.loadedRegion.y + 1;
            self.loadW()
            return
        }
        
        if self.playerRegion.x > self.loadedRegion.x {
            self.loadedRegion.x = self.loadedRegion.x + 1;
            self.loadD()
            return
        }
        
        if self.playerRegion.y < self.loadedRegion.y {
            self.loadedRegion.y = self.loadedRegion.y - 1;
            self.loadS()
            return
        }
    }
    
    func loadA() {
        /*
        0  1   2
        3  4   5
        6  7   8
        */
        self.chunks[2].destroy();
        self.chunks[5].destroy();
        self.chunks[8].destroy();

        self.chunks[2] = self.chunks[1];
        self.chunks[5] = self.chunks[4];
        self.chunks[8] = self.chunks[7];

        self.chunks[1] = self.chunks[0];
        self.chunks[4] = self.chunks[3];
        self.chunks[7] = self.chunks[6];

        self.chunks[0] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[0])
        self.chunks[3] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[3])
        self.chunks[6] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[6])

        self.addTiledMaps();
    }
    
    func loadS() {
        /*
        0  1   2
        3  4   5
        6  7   8
        */
        self.chunks[0].destroy();
        self.chunks[1].destroy();
        self.chunks[2].destroy();

        self.chunks[0] = self.chunks[3];
        self.chunks[1] = self.chunks[4];
        self.chunks[2] = self.chunks[5];

        self.chunks[3] = self.chunks[6];
        self.chunks[4] = self.chunks[7];
        self.chunks[5] = self.chunks[8];

        self.chunks[6] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[6])
        self.chunks[7] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[7])
        self.chunks[8] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[8])

        self.addTiledMaps();
    }
    
    func loadD() {
        /*
        0  1   2
        3  4   5
        6  7   8
        */
        self.chunks[0].destroy()
        self.chunks[3].destroy()
        self.chunks[6].destroy()
        
        self.chunks[0] = self.chunks[1]
        self.chunks[3] = self.chunks[4]
        self.chunks[6] = self.chunks[7]
        
        self.chunks[1] = self.chunks[2]
        self.chunks[4] = self.chunks[5]
        self.chunks[7] = self.chunks[8]
        
        self.chunks[2] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[2])
        self.chunks[5] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[5])
        self.chunks[8] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[8])
        
        self.addTiledMaps()
    }
    
    func loadW() {
        /*
         0  1   2
         3  4   5
         6  7   8
         */
        self.chunks[6].destroy()
        self.chunks[7].destroy()
        self.chunks[8].destroy()
        
        self.chunks[6] = self.chunks[3]
        self.chunks[7] = self.chunks[4]
        self.chunks[8] = self.chunks[5]
        
        self.chunks[3] = self.chunks[0]
        self.chunks[4] = self.chunks[1]
        self.chunks[5] = self.chunks[2]
        
        self.chunks[0] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[0])
        self.chunks[1] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[1])
        self.chunks[2] = TiledMap(fileNamed: "\(self.mapType)", position: self.loadedRegionList[2])
        
        self.addTiledMaps()
    }
}
