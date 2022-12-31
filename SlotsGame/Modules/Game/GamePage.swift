//
//  GamePage.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 26.12.2022.
//

import SwiftUI

fileprivate struct SideBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: .init(width: 80, height: 80))
        return Path(path.cgPath)
    }
}

struct GamePage: View {
    
    @State private var boardOffset: CGFloat = -min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    
    @State private var chestOffset: CGFloat = 250
    @State private var spinnerOffset: CGFloat = 250
    @State private var hstackOffset: CGFloat = 250
    
    @State private var animationIsActive = false
    
    @State private var isRotating = 0.0
    
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var state = GamePageState()
    
    var body: some View {
        ZStack {
            Image("slot-game-bg")
                .resizable()
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("home")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(EdgeInsets(top: 25, leading: 35, bottom: 0, trailing: 0))
                    }
                    Spacer()
                }
                Spacer()
            }
            HStack(spacing: 0) {
                VStack(spacing: 10) {
                    SlotBoardView()
                    Text("WIN: +\(state.score)")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                        .opacity(state.score >= 0 ? 1 : 0)
                }
                .padding(EdgeInsets(top: 55, leading: 90, bottom: 55, trailing: 35))
                .offset(y: boardOffset)
                .opacity(chestOffset == 0 ? 1 : 0)
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .frame(width: 238)
                        .clipShape(SideBarShape())
                    VStack {
                        VStack(spacing: 0) {
                            Image("chest")
                                .resizable()
                                .frame(width: 115, height: 97)
                                .zIndex(0)
                            ZStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(
                                        LinearGradient(colors: [
                                            .init(red: 0.95, green: 0.65, blue: 0.32),
                                            .init(red: 0.93, green: 0.47, blue: 0.25)
                                        ], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .frame(width: 170, height: 30)
                                Text(state.bankVolume.formattedWithSeparator)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            .zIndex(1)
                            .offset(y: -25)
                        }
                        .offset(x: chestOffset)
                        
                        ZStack {
                            Image("spinner")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .rotationEffect(.degrees(isRotating))
                                .onAppear {
                                    withAnimation(
                                        .linear(duration: 1)
                                        .speed(1).repeatForever(autoreverses: false)
                                    ) {
                                        isRotating = 360.0
                                    }
                                }
                                .offset(y: -12.5)
                                .opacity(state.isSpinning ? 1 : 0)
                            
                            Image("spinner")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .offset(y: -12.5)
                                .opacity(state.isSpinning ? 0 : 1)
                            
                            Button {
                                state.beginSpinning()
                            } label: {
                                Text("SPIN")
                                    .foregroundColor(.white)
                                    .font(.system(size: 38, weight: .bold))
                                    .offset(y: -12.5)
                                    .disabled(!state.isSpinning)
                            }
                        }
                        .offset(x: spinnerOffset)
                        
                        HStack {
                            Button {
                                state.decrementBet()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color.red, lineWidth: 1)
                                        .frame(width: 33, height: 33)
                                    Text("-")
                                        .font(.system(size: 22, weight: .bold))
                                }
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.red, lineWidth: 1)
                                    .frame(width: 88, height: 33)
                                Text("\(state.betValue)")
                                    .font(.system(size: 22, weight: .bold))
                            }
                            Button {
                                state.incrementBet()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color.red, lineWidth: 1)
                                        .frame(width: 33, height: 33)
                                    Text("+")
                                        .font(.system(size: 22, weight: .bold))
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .offset(x: hstackOffset)
                    }
                    .offset(x: -10)
                }
            }
            
            
            
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                withAnimation(.spring()) {
                    chestOffset = 0
                    boardOffset = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                withAnimation(.spring()) {
                    spinnerOffset = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
                withAnimation(.spring()) {
                    hstackOffset = 0
                }
            }
        }
    }
}

