//
//  Composition.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import Foundation

struct Composition {
    var id: UUID = UUID()
    var date: Date = Date()
    var listOfChampions: [Champion] = [Champion]()
}
