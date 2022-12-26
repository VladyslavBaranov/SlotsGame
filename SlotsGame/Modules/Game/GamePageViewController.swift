//
//  GamePageViewController.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 26.12.2022.
//

import SwiftUI

final class GamePageViewController: UIHostingController<GamePage> {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscapeLeft
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool { true }

    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { .bottom }
    
}
