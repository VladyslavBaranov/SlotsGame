//
//  MainPage.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 22.12.2022.
//

import SwiftUI

struct MainPageGamesClipShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: .init(width: 50, height: 50))
        return Path(path.cgPath)
    }
}

struct ColSpan<Content: View>: View {
    let span: Bool
    let content: () -> Content
    
    init(span: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.span = span
        self.content = content
    }
    
    var body: some View {
        content()
        if span {
            Color.clear
        }
    }
    
}

struct MainPage: View {
    
    @ObservedObject var state = MainPageState()
    
    private let gridItems = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    private let gridSidePadding: CGFloat = 34.0
    
    var body: some View {
        VStack {
            HStack {
                Image("profile-placeholder")
                    .resizable()
                    .frame(width: 45, height: 45)
                Spacer()
                HStack {
                    Image("chest")
                        .resizable()
                        .frame(width: 54, height: 45)
                        .offset(x: 15)
                        .zIndex(1)
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(red: 0.17, green: 0.16, blue: 0.21))
                            .frame(width: 130, height: 26)
                        Text("123456")
                            .font(.system(size: 18, weight: .bold))
                    }
                    .zIndex(0)
                }
            }
            .padding(EdgeInsets(top: 15, leading: 34, bottom: 15, trailing: 34))
            ScrollView {
                HStack {
                    VStack(spacing: 5) {
                        Button {
                            state.showsOnlyPopularGames = true
                        } label: {
                            Text("Popular")
                                .font(.system(size: 20, weight: state.showsOnlyPopularGames ? .bold : .regular))
                                .foregroundColor(state.showsOnlyPopularGames ? .white : .gray)
                        }
                        Color(red: 1, green: 0, blue: 0, opacity: state.showsOnlyPopularGames ? 1 : 0)
                            .frame(width: 60, height: 4)
                            .cornerRadius(2)
                    }
                    Spacer()
                    VStack(spacing: 5) {
                        Button {
                            state.showsOnlyPopularGames = false
                        } label: {
                            Text("All Games")
                                .font(.system(size: 20, weight: !state.showsOnlyPopularGames ? .bold : .regular))
                                .foregroundColor(!state.showsOnlyPopularGames ? .white : .gray)
                        }
                        Color(red: 1, green: 0, blue: 0, opacity: !state.showsOnlyPopularGames ? 1 : 0)
                            .frame(width: 60, height: 4)
                            .cornerRadius(2)
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 62, bottom: 30, trailing: 62))
                
                LazyVGrid(columns: gridItems, alignment: .leading, spacing: 20) {
                    
                    ForEach(state.filteredGames(), id: \.iconName) { game in
                        if game.isPopular {
                            ColSpan(span: true) {
                                Image(game.iconName)
                                    .resizable()
                                // Color.red
                                    .frame(
                                        width: UIScreen.main.bounds.width - gridSidePadding * 2,
                                        height: getGridItemHeight()
                                    )
                            }
                        } else {
                            ColSpan(span: false) {
                                Image(game.iconName)
                                    .resizable()
                                    .frame(height: getGridItemHeight())
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], gridSidePadding)
            }
            .background(Color(red: 0.08, green: 0.08, blue: 0.1))
            .clipShape(MainPageGamesClipShape())
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    private func getGridItemHeight() -> CGFloat {
        (UIScreen.main.bounds.width - gridSidePadding * 2) / 2 - 20
    }
    
}
