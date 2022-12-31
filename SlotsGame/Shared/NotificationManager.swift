//
//  NotificationManager.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 30.12.2022.
//

import Foundation

enum NotificationType: String {
    
    case didStartSpinning = "com.SlotsGame.didStartSpinning"
    case willEndSpinning = "com.SlotsGame.willEndSpinning"
    
    case didWinSlotGameWithValue = "com.SlotsGame.didWinSlotGameWithValue"
    
    case shouldResetWheelBoard = "com.SlotsGame.shouldResetWheelBoard"
}

extension Notification.Name {
    
    static let didStartSpinning = "com.SlotsGame.didStartSpinning"
    static let willEndSpinning = "com.SlotsGame.willEndSpinning"
    
    static let didWinSlotGameWithValue = "com.SlotsGame.didWinSlotGameWithValue"
    
    static let shouldResetWheelBoard = "com.SlotsGame.shouldResetWheelBoard"
}

final class NotificationManager {
    
    static let shared = NotificationManager()
    
    func post(_ type: NotificationType, object: Any? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: self.notificationName(for: type), object: object)
        }
    }
    
    func notificationName(for type: NotificationType) -> Notification.Name {
        Notification.Name(type.rawValue)
    }
}

