//
//  HomeViewModel.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import Foundation

struct HomeViewModel {

    // MARK: - Core Data

    func getCompositions() -> [Composition] {
        return LocalManagerServices.shared.read()
    }
}
