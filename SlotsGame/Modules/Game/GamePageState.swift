//
//  GamePageState.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 26.12.2022.
//

import Foundation

class GamePageState: ObservableObject {
    
    var spinAllowed = true
    
    @Published var bankVolume = KeyStore.getInteger(for: .bankValue) ?? 123456
    
    @Published var betValue: Int = 100
    
    @Published var isSpinning: Bool = false
    
    @Published var score = -1
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onWillEndSpinning),
            name: NotificationManager.shared.notificationName(for: .willEndSpinning),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didWinSlotGameWithValue(_:)),
            name: NotificationManager.shared.notificationName(for: .didWinSlotGameWithValue),
            object: nil
        )
    }
    
    @objc private func onWillEndSpinning() {
        isSpinning = false
    }
    
    @objc private func didWinSlotGameWithValue(_ notification: Notification) {
        if let score = notification.object as? Int {
            switch score {
            case 0:
                self.score = Int(Double(betValue) * 0.2)
            case 1:
                self.score = Int(Double(betValue) * 0.4)
            case 2:
                self.score = Int(Double(betValue) * 0.6)
            case 3:
                self.score = betValue
            case 4:
                self.score = betValue * 2
            default:
                break
            }
            bankVolume += self.score
            KeyStore.save(value: bankVolume, for: .bankValue)

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                NotificationManager.shared.post(.shouldResetWheelBoard)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
                self?.spinAllowed = true
            }
        }
    }
    
    func incrementBet() {
        if betValue < 1000 {
            betValue += 100
        }
    }
    
    func decrementBet() {
        if betValue > 100 {
            betValue -= 100
        }
    }
    
    func beginSpinning() {
        
        guard spinAllowed else { return }
        
        score = -1
        bankVolume -= betValue
        if !isSpinning {
            isSpinning = true
            NotificationManager.shared.post(.didStartSpinning)
        }
        
        spinAllowed = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
