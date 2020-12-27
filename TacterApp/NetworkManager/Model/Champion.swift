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
    let iconURL: String
}
