//
//  SlotItemCache.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 27.12.2022.
//

import UIKit

final class SlotItemCache {
    
    var images: [UIImage] = []
    
    static let shared = SlotItemCache()
    
    init() {
        for i in 1...9 {
            if let img = UIImage(named: "sg-\(i)") {
                images.append(img)
            }
        }
    }
}
