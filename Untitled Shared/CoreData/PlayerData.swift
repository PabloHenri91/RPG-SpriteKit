//
//  PlayerData.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {

    func newPlayerData() -> PlayerData {
        let playerData: PlayerData = self.insertNewObject()
        
        playerData.music = true
        playerData.name = ""
        playerData.points = 10000
        playerData.premiumPoints = 256
        playerData.sound = true
        
        return playerData
    }
    
    func updateModelVersion() {
        
        if self.playerData.modelVersion < 1 {
            self.playerData.modelVersion = 1
        }
    }
}
