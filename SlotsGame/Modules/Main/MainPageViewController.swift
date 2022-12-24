//
//  MainPageViewController.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 22.12.2022.
//

import SwiftUI

final class MainPageViewController: UIHostingController<MainPage> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayPreloader()
    }
}

private extension MainPageViewController {
    func setupUI() {
        view.backgroundColor = UIColor(red: 0.12, green: 0.11, blue: 0.14, alpha: 1)
    }
    
    func displayPreloader() {
        let vc = UIHostingController(rootView: PreloaderPage())
        vc.view.backgroundColor = UIColor(red: 0.12, green: 0.11, blue: 0.14, alpha: 1)
        addChild(vc)
        vc.view.frame = UIScreen.main.bounds
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            
            UIView.animate(withDuration: 0.3) {
                vc.view.alpha = 0
            } completion: { _ in
                vc.willMove(toParent: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }
    }
}
