//
//  MainPageState.swift
//  SlotsGame
//
//  Created by Vladyslav Baranov on 24.12.2022.
//

import Foundation

struct Game: Codable {

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iconName = "icon"
        case playedCountWorldWide = "played-count-worldwide"
        case iconNames = "slot-icon-names"
    }
    
    var name: String
    var iconName: String
    var playedCountWorldWide: Int
    var iconNames: [String]
    
    var isPopular: Bool {
        playedCountWorldWide > 10000
    }

}

fileprivate struct GameObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case gameList = "game-list"
    }
    
    var gameList: [Game]
}

final class MainPageState: ObservableObject {
    
    @Published var bankVolume = KeyStore.getInteger(for: .bankValue) ?? 123456
    
    var gameList: [Game] = []
    
    @Published var showsOnlyPopularGames = false
    
    init() {
        guard let url = Bundle.main.url(forResource: "Games", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let gameObject = try? JSONDecoder().decode(GameObject.self, from: data) else { return }
        gameList = gameObject.gameList
    }
    
    func filteredGames() -> [Game] {
        if showsOnlyPopularGames {
            return gameList.filter { $0.isPopular }
        } else {
            return gameList
        }
    }
}
