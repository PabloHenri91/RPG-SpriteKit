//
//  NewGameScene.swift
//  RPG-SpriteKit
//
//  Created by Pablo Henrique Bertaco on 29/03/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import SpriteKit

class NewGameScene: GameScene {
    
    enum state: String {
        case newGame
        case continueGame
        case mainMenu
    }
    
    var state: state = .newGame
    var nextState: state = .newGame
    
    let playableCharacter = PlayableCharacter(type: .none, level: 1, primaryAttribute: .none, secondaryAttribute: .none)
    
    var labelClass: Label! = nil
    var labelPrimaryAttribute: Label! = nil
    var labelSecondaryAttribute: Label! = nil
    var buttonAccept: Button! = nil
    
    weak var box: Box? = nil

    override func load() {
        super.load()
        
        let buttonBack = Button(imageNamed: "button_26x26", text: "<", x: 10, y: 234, horizontalAlignment: .left, verticalAlignment: .bottom)
        self.addChild(buttonBack)
        buttonBack.addHandler { [weak self] in
            guard let `self` = self else { return }
            self.nextState = .mainMenu
        }
        
        let buttonClass = Button(imageNamed: "button_110x26", text: "Class", x: 125, y: 86, horizontalAlignment: .center, verticalAlignment: .center)
        self.addChild(buttonClass)
        buttonClass.addHandler { [weak self] in
            guard let `self` = self else { return }
            let box = BoxChooseClass(completion:  { [weak self] (type: PlayableCharacter.type) in
                guard let `self` = self else { return }
                self.changeType(type: type)
            })
            box.show(gameScene: self)
            self.box = box
        }
        
        let buttonPrimaryAttribute = Button(imageNamed: "button_110x26", text: "Primary Attribute", x: 125, y: 122, horizontalAlignment: .center, verticalAlignment: .center)
        self.addChild(buttonPrimaryAttribute)
        buttonPrimaryAttribute.addHandler { [weak self] in
            guard let `self` = self else { return }
            let box = BoxChooseAttribute(hiddenAttribute: self.playableCharacter.secondaryAttribute, completion:  { [weak self] (attribute: PlayableCharacter.attribute) in
                guard let `self` = self else { return }
                self.changePrimaryAttribute(attribute: attribute)
            })
            box.show(gameScene: self)
            self.box = box
        }
        
        let buttonSecondaryAttribute = Button(imageNamed: "button_110x26", text: "Secondary Attribute", x: 125, y: 158, horizontalAlignment: .center, verticalAlignment: .center)
        self.addChild(buttonSecondaryAttribute)
        buttonSecondaryAttribute.addHandler { [weak self] in
            guard let `self` = self else { return }
            let box = BoxChooseAttribute(hiddenAttribute: self.playableCharacter.primaryAttribute, completion:  { [weak self] (attribute: PlayableCharacter.attribute) in
                guard let `self` = self else { return }
                self.changeSecondaryAttribute(attribute: attribute)
            })
            box.show(gameScene: self)
            self.box = box
        }
        
        let controlClass = Control(imageNamed: "textBox_110x26", x: 245, y: 86, horizontalAlignment: .center, verticalAlignment: .center)
        self.addChild(controlClass)
        let labelClass = Label(text: "\(self.playableCharacter.type)", fontColor: GameColors.fontWhite, x: 55, y: 13)
        controlClass.addChild(labelClass)
        self.labelClass = labelClass
        
        let controlPrimaryAttribute = Control(imageNamed: "textBox_110x26", x: 245, y: 122, horizontalAlignment: .center, verticalAlignment: .center)
        self.addChild(controlPrimaryAttribute)
        let labelPrimaryAttribute = Label(text: "\(self.playableCharacter.primaryAttribute)", fontColor: GameColors.fontWhite, x: 55, y: 13)
        controlPrimaryAttribute.addChild(labelPrimaryAttribute)
        self.labelPrimaryAttribute = labelPrimaryAttribute
        
        let controlSecondaryAttribute = Control(imageNamed: "textBox_110x26", x: 245, y: 158, horizontalAlignment: .center, verticalAlignment: .center)
        self.addChild(controlSecondaryAttribute)
        let labelSecondaryAttribute = Label(text: "\(self.playableCharacter.secondaryAttribute)", fontColor: GameColors.fontWhite, x: 55, y: 13)
        controlSecondaryAttribute.addChild(labelSecondaryAttribute)
        self.labelSecondaryAttribute = labelSecondaryAttribute
        
        let buttonAccept = Button(imageNamed: "button_110x26", text: "Accept", x: 185, y: 234, horizontalAlignment: .center, verticalAlignment: .bottom)
        self.addChild(buttonAccept)
        self.buttonAccept = buttonAccept
        self.buttonAcceptUpdate()
        buttonAccept.addHandler { [weak self] in
            guard let `self` = self else { return }
            self.buttonAcceptAction()
        }
    }
    
    func buttonAcceptUpdate() {
        self.buttonAccept.isHidden = self.playableCharacter.type == .none
            || self.playableCharacter.primaryAttribute == .none
            || self.playableCharacter.secondaryAttribute == .none
    }
    
    func buttonAcceptAction() {
        let memoryCard = MemoryCard.sharedInstance
        let playerData = memoryCard.playerData!
        let characterData = memoryCard.newCharacterData(playableCharacter: self.playableCharacter)
        playerData.addToCharacterList(characterData)
        playerData.load(character: characterData)
        self.nextState = .continueGame
    }
    
    func changeType(type: PlayableCharacter.type) {
        self.box?.remove()
        self.playableCharacter.type = type
        self.labelClass.text = "\(type)"
        self.buttonAcceptUpdate()
    }
    
    func changePrimaryAttribute(attribute: PlayableCharacter.attribute) {
        self.box?.remove()
        self.playableCharacter.primaryAttribute = attribute
        self.labelPrimaryAttribute.text = "\(attribute)"
        self.buttonAcceptUpdate()
    }
    
    func changeSecondaryAttribute(attribute: PlayableCharacter.attribute) {
        self.box?.remove()
        self.playableCharacter.secondaryAttribute = attribute
        self.labelSecondaryAttribute.text = "\(attribute)"
        self.buttonAcceptUpdate()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if self.state == self.nextState {
            
            switch self.state {
                
            case .mainMenu:
                break
            case .newGame:
                break
            case .continueGame:
                break
            }
        } else {
            self.state = self.nextState
            
            switch self.nextState {
                
            case .mainMenu:
                self.view?.presentScene(MainMenuScene(), transition: GameScene.defaultTransition)
                break
            case .newGame:
                break
            case .continueGame:
                self.view?.presentScene(BattleScene(), transition: GameScene.defaultTransition)
                break
            }
        }
    }
}
