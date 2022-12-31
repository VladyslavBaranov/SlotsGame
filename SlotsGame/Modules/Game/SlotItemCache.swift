//
//  SlotItemCache.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 27.12.2022.
//

import UIKit

final class SlotItemCache {
    
    var iconNames: [String] = []
    var images: [UIImage] = []
    
    static let shared = SlotItemCache()
    
    init() {
        for i in 1...9 {
            if let img = UIImage(named: "sg-\(i)") {
                images.append(img)
            }
        }
    }
    
    func resetCache(_ iconNames: [String]) {
        self.iconNames = iconNames
        images.removeAll()
        for iconName in iconNames {
            if let img = UIImage(named: iconName) {
                images.append(img)
            }
        }
    }
}
