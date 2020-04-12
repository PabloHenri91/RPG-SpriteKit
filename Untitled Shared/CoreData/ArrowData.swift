//
//  ArrowData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 11/04/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {
    
    func newArrowData(arrow: Arrow) -> ArrowData {
        let arrowData: ArrowData = self.insertNewObject()
        arrowData.load(item: arrow)
        return arrowData
    }
}
