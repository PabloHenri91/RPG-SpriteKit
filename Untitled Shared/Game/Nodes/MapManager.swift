//
//  MapManager.swift
//  Untitled iOS
//
//  Created by John Reis on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class MapManager: NSObject, TiledMapDelegate {
    
    var lastUpdate: TimeInterval = 0
    var loading = false
    var loadedRegionList = [Int: CGPoint]()
    var loadedRegion = CGPoint.zero { didSet { self.didSetLoadedRegion() } }
    var playerRegion = CGPoint.zero
    var chunks = [TiledMap]()
    var mapType = "world"
    
    weak var delegate: MapManagerDelegate?
    
    static weak var current: MapManager?
    
    init(mapManagerDelegate: MapManagerDelegate? = nil) {
        super.init()
        self.delegate = mapManagerDelegate
        MapManager.current = self
    }
    
    func reload(position: CGPoint) {
        
        self.updatePlayerRegion(position: position)
        self.loadedRegion = self.playerRegion
        
        for chunk in self.chunks {
            chunk.destroy()
        }
        
        var i = 0
        for _ in [self.playerRegion.y - 1, self.playerRegion.y, self.playerRegion.y + 1] {
            for _ in [self.playerRegion.x - 1, self.playerRegion.x, self.playerRegion.x + 1] {
                let chunk = TiledMap(mapType: self.mapType, position: self.loadedRegionList[i], delegate: self)
                i = i + 1
                self.chunks.append(chunk)
            }
        }
        
        self.addTiledMaps();
        
        self.loadedRegion = self.playerRegion
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
        self.chunks[2].destroy();
        self.chunks[5].destroy();
        self.chunks[8].destroy();

        self.chunks[2] = self.chunks[1];
        self.chunks[5] = self.chunks[4];
        self.chunks[8] = self.chunks[7];

        self.chunks[1] = self.chunks[0];
        self.chunks[4] = self.chunks[3];
        self.chunks[7] = self.chunks[6];

        self.chunks[0] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[0], delegate: self)
        self.chunks[3] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[3], delegate: self)
        self.chunks[6] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[6], delegate: self)

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

        self.chunks[6] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[6], delegate: self)
        self.chunks[7] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[7], delegate: self)
        self.chunks[8] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[8], delegate: self)

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
        
        self.chunks[2] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[2], delegate: self)
        self.chunks[5] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[5], delegate: self)
        self.chunks[8] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[8], delegate: self)
        
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
        
        self.chunks[0] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[0], delegate: self)
        self.chunks[1] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[1], delegate: self)
        self.chunks[2] = TiledMap(mapType: self.mapType, position: self.loadedRegionList[2], delegate: self)
        
        self.addTiledMaps()
    }
    
    func addTile(_ tiledMap: TiledMap, id: Int, texture: SKTexture?, x: Int, y: Int) -> Bool {
        if let delegate = self.delegate {
            return delegate.addTile(self, tiledMap, id: id, texture: texture, x: x, y: y)
        }
        return false
    }
    
    func addObjectGroup(_ tiledMap: TiledMap, objectGroup: TiledObjectGroup) {
        self.delegate?.addObjectGroup(self, tiledMap, objectGroup: objectGroup)
    }
    
    func addTiledMaps() {
        guard let gameWorld = GameWorld.current else { return }
        for chunk in self.chunks {
            if chunk.parent == nil {
                gameWorld.addChild(chunk)
            }
        }
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

protocol MapManagerDelegate: class {
    func addTile(_ mapManagerDelegate: MapManager, _ tiledMap: TiledMap, id: Int, texture: SKTexture?, x: Int, y: Int) -> Bool // handled ?
    func addObjectGroup(_ mapManagerDelegate: MapManager, _ tiledMap: TiledMap, objectGroup: TiledObjectGroup)
}
