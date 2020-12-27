//
//  ChampionViewModel.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

struct ChampionViewModel {

    private let champion: Champion

    var championIconURL: URL? {
        guard let iconURL = champion.iconURL else { return nil }
        return URL(string: iconURL)
    }

    var championName: String? {
        return champion.name
    }

    init(champion: Champion) {
        self.champion = champion
    }
}

