//
//  TiledMap.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 21/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class TiledMap: SKNode, XMLParserDelegate {
    
    static var currentSize = CGSize(width: 512, height: 512)
    
    init(fileNamed filename: String, x: CGFloat, y: CGFloat) {
        super.init()
        self.addChild(SKLabelNode(text: "\(Int(x)) \(Int(y))"))
        self.position.x = TiledMap.currentSize.width * x
        self.position.y = TiledMap.currentSize.height * y
//        guard let url = Bundle.main.url(forResource: filename, withExtension: "tmx") else { return }
//        guard let parser = XMLParser(contentsOf: url) else { return }
//        parser.delegate = self
//        parser.parse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("\(parser.description)")
        print("\(elementName)")
        print("\(namespaceURI ?? "nil")")
        print("\(qName ?? "nil")")
        print("\(attributeDict.description)")
    }
}
