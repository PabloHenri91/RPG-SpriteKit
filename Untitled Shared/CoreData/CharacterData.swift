//
//  CharacterData.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 29/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import CoreData

extension MemoryCard {
    
    func newCharacterData(playableCharacter: PlayableCharacter) -> CharacterData {
        let characterData: CharacterData = self.insertNewObject()
        characterData.level = Int16(playableCharacter.level)
        characterData.primaryAttribute = Int16(playableCharacter.primaryAttribute.rawValue)
        characterData.secondaryAttribute = Int16(playableCharacter.secondaryAttribute.rawValue)
        characterData.selected = false
        characterData.type = Int16(playableCharacter.type.rawValue)
        characterData.xp = 0
        characterData.backpack = self.newBackpackData(backpack: Backpack())
        characterData.chest = self.newArmorData(armor: Armor())
        
        switch playableCharacter.type {
        case .warrior:
            self.configureNewWarrior(characterData: characterData)
            break
        case .mage:
            self.configureNewMage(characterData: characterData)
            break
        case .ranger:
            self.configureNewRanger(characterData: characterData)
            break
        default:
            break
        }
        
        self.cheatFillBackpack(characterData: characterData)
        
        return characterData
    }
    
    func cheatFillBackpack(characterData: CharacterData) {
        guard let backpack = characterData.backpack else { return }
        backpack.rarity = Int16(Item.rarity.supreme.rawValue)
        backpack.level = 10
        for _ in 0..<64 {
            if let itemData = self.newItemData(item: Item.random()) {
                backpack.addToItemList(itemData)
            }
        }
    }
    
    func configureNewWarrior(characterData: CharacterData) {
        characterData.leftHand = self.newShieldData(shield: Shield())
        characterData.rightHand = self.newWeaponData(weapon: Weapon(type: .melee))
    }
    
    func configureNewMage(characterData: CharacterData) {
        characterData.leftHand = self.newShieldData(shield: Shield())
        characterData.rightHand = self.newWeaponData(weapon: Weapon(type: .magic))
    }
    
    func configureNewRanger(characterData: CharacterData) {
        characterData.leftHand = self.newArrowData(arrow: Arrow())
        characterData.rightHand = self.newWeaponData(weapon: Weapon(type: .ranged))
    }
}

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
