//
//  Music.swift
//  Untitled
//
//  Created by Pablo Henrique Bertaco on 19/02/20.
//  Copyright © 2020 OrganizationName. All rights reserved.
//

import AVFoundation

class Music {

    enum musicType {
        case noMusic
        case menu
        case battle
    }
    
    struct fileName {
        static var menu = [
            "musicA.m4a"
        ]
        static var battle = [
            "musicB.m4a",
            "musicC.m4a",
            "musicD.m4a"
        ]
    }
    
    static var sharedInstance = Music()
    
    private var audioPlayer: AVAudioPlayer?
    private var musicName = ""
    private var musicType: musicType = .noMusic
    
    func playMusic(withType musicType: musicType) {
        guard self.musicType != musicType else { return }
        self.musicType = musicType
        
        switch musicType {
        case .noMusic:
            return
        case .menu:
            self.playMusic(withName: fileName.menu[Int.random(fileName.menu.count)])
            break
        case .battle:
            self.playMusic(withName: fileName.battle[Int.random(fileName.battle.count)])
            break
        }
    }
    
    func playMusic(withName name: String) {
        guard self.musicName != name else { return }
        self.musicName = name
        
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            #if DEBUG
            return // fatalError()
            #else
            return
            #endif
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            self.audioPlayer = audioPlayer
            self.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func play() {
        if MemoryCard.sharedInstance.playerData.music {
            if let audioPlayer = self.audioPlayer {
                audioPlayer.play()
            }
        } else {
            self.pause()
        }
    }
    
    func pause() {
        self.audioPlayer?.pause()
    }
    
    func stop() {
        self.audioPlayer?.volume = 0
        self.audioPlayer?.stop()
    }
}
