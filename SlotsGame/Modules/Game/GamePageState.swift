//
//  GamePageState.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 26.12.2022.
//

import Foundation

class GamePageState: ObservableObject {
    
    @Published var betValue: Int = 100
    
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
    
}
