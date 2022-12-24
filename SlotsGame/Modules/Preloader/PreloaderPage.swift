//
//  PreloaderPage.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 22.12.2022.
//

import SwiftUI

struct PreloaderPage: View {
    
    @State private var fakeProgress = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Image("chest")
                .resizable()
                .frame(width: 142, height: 119)
            Group {
                Text(AttributedString(buildAttributedString()))
            }
            
            ProgressView(value: fakeProgress, total: 1)
                .tint(Color(red: 0.39, green: 0.86, blue: 0.81))
                .progressViewStyle(LinearProgressViewStyle())
                .padding([.trailing, .leading], 38)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation(Animation.linear(duration: 3)) {
                    fakeProgress = 1
                }
            }
        }
    }
    
    private func buildAttributedString() -> NSAttributedString {
        let testString = NSAttributedString(string: "Test", attributes: [
            .foregroundColor: UIColor(red: 0.39, green: 0.86, blue: 0.81, alpha: 1),
        ])
        let appDesignString = NSAttributedString(string: " App Design", attributes: [
            .foregroundColor: UIColor.white,
        ])
        let finalString = NSMutableAttributedString()
        finalString.append(testString)
        finalString.append(appDesignString)
        finalString.addAttributes([
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .kern: 2
        ], range: NSRange(location: 0, length: finalString.length))
        return finalString
    }
}
