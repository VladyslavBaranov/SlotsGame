//
//  MainPageViewController.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 22.12.2022.
//

import SwiftUI

final class MainPageViewController: UIHostingController<MainPage> {
    
    override init(rootView: MainPage) {
        super.init(rootView: rootView)
        self.rootView.didTapGame = { [weak self] game in
            let vc = GamePageViewController(rootView: .init())
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayPreloader()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // OrientationLock.lockOrientation(.portrait)
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
