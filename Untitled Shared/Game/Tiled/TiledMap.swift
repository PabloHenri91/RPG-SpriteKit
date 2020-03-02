//
//  TiledMap.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class TiledMap: SKNode, XMLParserDelegate {
    
    static var width: CGFloat = 64
    static var height: CGFloat = 64
    static var tileWidth: CGFloat = 32
    static var tileHeight: CGFloat = 32
    
    static var size: CGSize {
        get {
            return CGSize(width: TiledMap.width * TiledMap.tileWidth,
                          height: TiledMap.height * TiledMap.tileHeight)
        }
    }
    
    var layerName = ""
    
    var tilesets = [Tileset]()
    
    init(fileNamed filename: String, x: CGFloat, y: CGFloat) {
        super.init()
        self.addChild(SKLabelNode(text: "\(Int(x)) \(Int(y))"))
        self.position.x = TiledMap.size.width * x
        self.position.y = TiledMap.size.height * y
        guard let url = self.url(forResource: filename) else {
            return
        }
        guard let parser = XMLParser(contentsOf: url) else {
            return
        }
        parser.delegate = self
        parser.parse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func url(forResource name: String?) -> URL? {
        var url = Bundle.main.url(forResource: name, withExtension: "tmx")
        if url == nil {
            url = Bundle.main.url(forResource: "default", withExtension: "tmx")
        }
        return url
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        switch elementName {
        case "map":
            TiledMap.width = CGFloat(Int(attributeDict["width"] ?? "") ?? -1)
            TiledMap.height = CGFloat(Int(attributeDict["height"] ?? "") ?? -1)
            TiledMap.tileWidth = CGFloat(Int(attributeDict["tilewidth"] ?? "") ?? -1)
            TiledMap.tileHeight = CGFloat(Int(attributeDict["tileheight"] ?? "") ?? -1)
            break
        case "tileset":
            
            let name = (attributeDict["name"] ?? "")
            let tileWidth = Int(attributeDict["tilewidth"] ?? "") ?? -1
            let tileHeight = Int(attributeDict["tileheight"] ?? "") ?? -1
            
            let tileset = Tileset(imageNamed: name)
            tileset.load(tileWidth: tileWidth, tileHeight: tileHeight)
            
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
            self.layerName = attributeDict["name"] ?? ""
            break
        case "data":
            break
        case "object":
            
            let height = Int(attributeDict["height"] ?? "") ?? -1
            let name = attributeDict["name"] ?? ""
            let id = Int(attributeDict["id"] ?? "") ?? -1
            let width = Int(attributeDict["width"] ?? "") ?? -1
            let x = Int(attributeDict["x"] ?? "") ?? -1
            let type = attributeDict["type"] ?? ""
            let y = Int(attributeDict["y"] ?? "") ?? -1
            
            switch type {
            default:
                print("Tipo de objeto desconhecido: \(type)")
                break
            }
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
        var i = data.makeIterator()
        for y in 0..<Int(TiledMap.height) {
            for x in 0..<Int(TiledMap.width) {
                guard let id = Int(i.next()?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "") else { continue }
                guard id != 0 else { continue }
                switch(id) {
                default:
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
                    break
                }
            }
        }
    }
}
