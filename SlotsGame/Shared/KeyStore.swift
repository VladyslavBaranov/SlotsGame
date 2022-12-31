//
//  KeyStore.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 31.12.2022.
//

import Foundation

struct KeyStore {
    
    enum Key: String {
        case bankValue = "com.SlotsGame.bankValue"
    }
    
    static func save(value: Any?, for key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getInteger(for key: Key) -> Int? {
        UserDefaults.standard.value(forKey: key.rawValue) as? Int
    }
    
}
