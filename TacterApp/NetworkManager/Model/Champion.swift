//
//  Champion.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import Foundation

struct Champion: Codable {

    // MARK: - Properties

    let championId: Int
    let name: String
    let cost: Int
    let costColor: String
    let iconURL: String?

    init() {
        championId = -1
        name = ""
        cost = -1
        costColor = ""
        iconURL = ""
    }

    init(championId: Int, name: String, cost: Int, costColor: String, iconURL: String?) {
        self.championId = championId
        self.name = name
        self.cost = cost
        self.costColor = costColor
        self.iconURL = iconURL
    }
}
