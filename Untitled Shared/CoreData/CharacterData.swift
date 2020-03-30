//
//  CharacterData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 29/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension PlayerData {
    
    func getCharacterList() -> Set<CharacterData> {
        return self.characterList as? Set<CharacterData> ?? []
    }

    func selectedCharacter() -> CharacterData? {
        return self.getCharacterList().first(where: { $0.selected })
    }
    
    func load(character: CharacterData) {
        self.selectedCharacter()?.selected = false
        character.selected = true
    }
}
