//
//  TestViewController.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 26.12.2022.
//

import SwiftUI

class WheelUIView: UIView {
    
    let img = UIImage(named: "sg-1")
    
    var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: frame)
        scrollView.showsVerticalScrollIndicator = false
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
        scrollView.contentSize = .init(width: bounds.width, height: dimension * 5)
    }
    
    func initiateViews() {
        let dimension = bounds.height / 3
        for i in 0...4 {
            let subView = Cell(frame: .init(x: 0, y: dimension * CGFloat(i), width: bounds.width, height: dimension))
            scrollView.addSubview(subView)
            subView.imageView.image = SlotItemCache.shared.images[Int.random(in: 0...8)]
            subView.backgroundColor = .clear
        }
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


class Cell: UIView {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = bounds.insetBy(dx: 15, dy: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TestViewController: UIViewController {
    
    var timer: Timer!
    
    let colors: [UIColor] = [
        .red, .green, .blue, .yellow, .purple, .orange,
        .red, .green, .blue, .yellow, .purple, .orange,
        .red, .green, .blue, .yellow, .purple, .orange,
        .red, .green, .blue, .yellow, .purple, .orange,
        .red, .green, .blue, .yellow, .purple, .orange,
        .red, .green, .blue, .yellow, .purple, .orange,
    ]
    
    var collectionView: UIScrollView!
    
    var displayLink: CADisplayLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        collectionView = UICollectionView(
            frame: .init(x: 0, y: 0, width: 200, height: 600),
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        // collectionView.dataSource = self
        // collectionView.register(Cell.self, forCellWithReuseIdentifier: "id")
        view.addSubview(collectionView)
        collectionView.decelerationRate = .init(rawValue: 1)
        collectionView.center = view.center
        
        //timer = Timer.scheduledTimer(withTimeInterval: 0.0005, repeats: true, block: { _ in
        //    self.collectionView.contentOffset.y += 1
        //})
        
        for i in 0..<colors.count {
            let subView = Cell(frame: .init(x: 0, y: 200 * CGFloat(i), width: 200, height: 200))
            collectionView.addSubview(subView)
            // subView.imageView.image = img
            subView.backgroundColor = .clear
        }
        
        collectionView.contentSize = CGSize(width: 200, height: 200 * colors.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            let timingF = CAMediaTimingFunction(controlPoints: 0.1, 0.5, 0, 1)
            
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(timingF)
            
            UIView.animate(withDuration: 2) {
                self.collectionView.contentOffset = .init(x: 0, y: 200 * 20)
            }
            
            CATransaction.commit()
            
            //v UIView.animate(withDuration: 1) {
                // self.collectionView.scrollToItem(at: .init(item: 12, section: 0), at: .centeredVertically, animated: false)
                
                //self.collectionView.reloadItems(at: [.init(item: 0, section: 0)])
                // self.view.layoutIfNeeded()
            // }
        }
    }
    

}

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // print(scrollView.contentOffset)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count * 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
}

extension TestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 200, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
