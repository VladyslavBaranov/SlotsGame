//
//  TestViewController.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 26.12.2022.
//

import SwiftUI

class WheelUIViewCell: UIView {
    
    var iconName: String = ""
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        let screenSize = UIScreen.main.bounds.size
        let maxDimension = max(screenSize.width, screenSize.height)
        let inset: CGFloat = maxDimension < 800 ? 0 : 9
        imageView.frame = bounds.insetBy(dx: inset, dy: inset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class WheelUIView: UIView {
    
    var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: frame)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = false
        addSubview(scrollView)
        initiateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        let dimension = bounds.height / 3
        for (i, view) in scrollView.subviews.enumerated() {
            view.frame = .init(x: 0, y: dimension * CGFloat(i), width: bounds.width, height: dimension)
        }
        scrollView.contentSize = .init(
            width: bounds.width,
            height: dimension * CGFloat(Constants.wheelItemVolume)
        )
    }
    
    func initiateViews() {
        let dimension = bounds.height / 3
        for i in 0..<Constants.wheelItemVolume {
            let subView = WheelUIViewCell(
                frame: .init(x: 0, y: dimension * CGFloat(i), width: bounds.width, height: dimension))
            scrollView.addSubview(subView)
            
            let randomIndex = Int.random(in: 0...8)
            subView.imageView.image = SlotItemCache.shared.images[randomIndex]
            subView.iconName = SlotItemCache.shared.iconNames[randomIndex]
            
            subView.backgroundColor = .clear
        }
    }
    
    func beginScroll() {
        let dimension = bounds.height / 3
        let timingF = CAMediaTimingFunction(controlPoints: 0.1, 0.5, 0, 1)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingF)
        
        UIView.animate(withDuration: 3) { [weak self] in
            self?.scrollView.contentOffset = .init(x: 0, y: dimension * 35)
        }
        
        CATransaction.commit()
    }
    
    func reset() {
        for subview in scrollView.subviews {
            if let cell = subview as? WheelUIViewCell {
                let index = Int.random(in: 0...8)
                cell.iconName = SlotItemCache.shared.iconNames[index]
                cell.imageView.image = SlotItemCache.shared.images[index]
            }
        }
        scrollView.setContentOffset(.zero, animated: true)
    }
}

struct WheelView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WheelUIView {
        let view = WheelUIView()
        return view
    }
    
    func updateUIView(_ uiView: WheelUIView, context: Context) {
        
    }
    
    typealias UIViewType = WheelUIView
    
}
