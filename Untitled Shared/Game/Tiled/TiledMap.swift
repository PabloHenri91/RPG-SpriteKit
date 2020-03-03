//
//  TiledMap.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class TiledMap: SKNode, XMLParserDelegate {
    
    var version = ""
    var tiledVersion = ""
    var orientation = ""
    var renderOrder = ""
    var compressionLevel = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    var infinite = false
    var nextLayerId = 0
    var nextObjectId = 0
    
    var size: CGSize {
        get {
            return CGSize(width: self.width * self.tileWidth,
                          height: self.height * self.tileHeight)
        }
    }
    
    var layerName = ""
    
    var tilesets = [Tileset]()
    
    static var current: TiledMap?
    
    init(fileNamed filename: String, x: CGFloat, y: CGFloat) {
        super.init()
        guard let url = self.url(forResource: filename) else {
            return
        }
        guard let parser = XMLParser(contentsOf: url) else {
            return
        }
        TiledMap.current = self
        parser.delegate = self
        parser.parse()
        self.position.x = self.size.width * x
        self.position.y = self.size.height * y
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func url(forResource name: String?) -> URL? {
        let url = Bundle.main.url(forResource: name, withExtension: "tmx")
        if url == nil {
            return Bundle.main.url(forResource: "default", withExtension: "tmx")
        }
        return url
    }
    
    func bool(key:String, from attributeDict: [String : String]) -> Bool {
        return attributeDict[key] ?? "0" == "1"
    }
    
    func int(key:String, from attributeDict: [String : String]) -> Int {
        return Int(attributeDict[key] ?? "") ?? -1
    }
    
    func float(key:String, from attributeDict: [String : String]) -> CGFloat {
        return CGFloat(Int(attributeDict[key] ?? "") ?? -1)
    }
    
    func string(key:String, from attributeDict: [String : String]) -> String {
        return attributeDict[key] ?? ""
    }
    
    func configure(attributeDict: [String : String]) {
        self.version =  self.string(key: "version", from: attributeDict)
        self.tiledVersion = self.string(key: "tiledversion", from: attributeDict)
        self.orientation = self.string(key: "orientation", from: attributeDict)
        self.renderOrder = self.string(key: "renderorder", from: attributeDict)
        self.compressionLevel = self.string(key: "compressionlevel", from: attributeDict)
        self.width = self.float(key: "width", from: attributeDict)
        self.height = self.float(key: "height", from: attributeDict)
        self.tileWidth = self.float(key: "tilewidth", from: attributeDict)
        self.tileHeight = self.float(key: "tileheight", from: attributeDict)
        self.infinite = self.bool(key: "infinite", from: attributeDict)
        self.nextLayerId = self.int(key: "nextlayerid", from: attributeDict)
        self.nextObjectId = self.int(key: "nextobjectid", from: attributeDict)
    }
    
    func loadTileset(attributeDict: [String : String]) -> Tileset {
        // let firstgid = self.int(key: "firstgid", from: attributeDict)
        let name = self.string(key: "name", from: attributeDict)
        let tileWidth = self.float(key: "tilewidth", from: attributeDict)
        let tileHeight = self.float(key: "tileheight", from: attributeDict)
        // let tilecount = self.int(key: "tilecount", from: attributeDict)
        // let columns = self.int(key: "columns", from: attributeDict)
        
        let tileset = Tileset(imageNamed: name)
        tileset.load(tileWidth: tileWidth, tileHeight: tileHeight)
        
        return tileset
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        switch elementName {
        case "map":
            self.configure(attributeDict: attributeDict)
            break
        case "tileset":
            let tileset = self.loadTileset(attributeDict: attributeDict)
            self.tilesets.append(tileset)
            break
        case "image":
            break
        case "terraintypes":
            break
        case "terrain":
            break
        case "tile":
            break
        case "layer":
            self.layerName = self.string(key: "name", from: attributeDict)
            break
        case "data":
            break
        case "object":
            break
        default:
            print("elementName: \(elementName)")
            print("attributeDict: \(attributeDict)\n")
            break
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let string = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.isEmpty == false {
            self.loadLayer(data: string.components(separatedBy: ","))
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parser.delegate = nil
    }
    
    func loadLayer(data: [String]) {
        guard let tiledMap = TiledMap.current else {
            return
        }
        
        var i = data.makeIterator()
        for y in 0..<Int(tiledMap.height) {
            for x in 0..<Int(tiledMap.width) {
                guard let id = Int(i.next()?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "") else { continue }
                guard id != 0 else { continue }
                var tilecount = 0
                for tileset in self.tilesets {
                    let lastTilecount = tilecount
                    tilecount = tilecount + tileset.tileTextures.count
                    
                    if id > lastTilecount && id <= tilecount {
                        let texture = tileset.tileTextures[id - lastTilecount - 1]
                        self.addChild(TiledTile(texture: texture, x: x, y: y))
                        break
                    }
                }
            }
        }
    }
}
