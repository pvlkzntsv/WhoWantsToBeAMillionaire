//
//  SoundsManager.swift
//  Millionaire
//
//  Created by Eldar Garbuzov on 9.02.23.
//

import UIKit
import AVFoundation

struct SoundsManager {
    
    private var player: AVAudioPlayer?
    
    enum Sounds {
        case correctAnswer
        case wrongAnswer
        case answerAccepted
        case timerSound
        case wonMillion
        
        var sounds: String {
            switch self {
            case .correctAnswer:
                return "correct-answer"
            case .wrongAnswer:
                return "wrong-answer"
            case .answerAccepted:
                return "otvet-prinyat"
            case .timerSound:
                return "timer-sound"
            case .wonMillion:
                return "player-wins-a-million"
            }
        }
    }
    
    mutating func playSound(_ soundName: Sounds) {
        guard let url = Bundle.main.url(forResource: soundName.sounds, withExtension: "mp3") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}
