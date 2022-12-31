//
//  SlotBoardView.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 30.12.2022.
//

import SwiftUI

class SlotBoardUIView: UIView {
    
    var columns: [WheelUIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for _ in 0..<5 {
            let wheelView = WheelUIView(frame: bounds)
            columns.append(wheelView)
            addSubview(wheelView)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(shouldStartSpinning),
            name: NotificationManager.shared.notificationName(for: .didStartSpinning),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(shouldResetWheelBoard),
            name: NotificationManager.shared.notificationName(for: .shouldResetWheelBoard),
            object: nil
        )
    }
    
    @objc private func shouldResetWheelBoard() {
        for column in columns {
            column.reset()
        }
    }
    
    @objc private func shouldStartSpinning() {
        
        for (i, view) in columns.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i * 3)) {
                view.beginScroll()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(16)) {
            NotificationManager.shared.post(.willEndSpinning)
            self.testForResult()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let dimension = bounds.width / CGFloat(columns.count == 0 ? 5 : columns.count)
        for (i, view) in columns.enumerated() {
            view.frame = .init(
                x: dimension * CGFloat(i),
                y: 0,
                width: dimension,
                height: bounds.height)
        }
    }
    
    func testForResult() {
        var similarIconsSet: Set<String> = []
        for i in 0...4 {
            if let cell = columns[i].scrollView.subviews[36] as? WheelUIViewCell {
                similarIconsSet.insert(cell.iconName)
            }
        }
        let score = 5 - similarIconsSet.count
        NotificationManager.shared.post(.didWinSlotGameWithValue, object: score)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

struct SlotBoardView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> SlotBoardUIView {
        let view = SlotBoardUIView(frame: .zero)
        return view
    }
    
    func updateUIView(_ uiView: SlotBoardUIView, context: Context) {
        
    }
    
    typealias UIViewType = SlotBoardUIView
    
}
 
