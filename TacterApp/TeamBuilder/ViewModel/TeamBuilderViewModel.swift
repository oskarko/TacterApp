//
//  TeamBuilderViewModel.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import Foundation

struct TeamBuilderViewModel {
    func getChampionsList(completionHandler: @escaping ([Champion]?) -> Void) {
        ManagerServices.shared.getChampionsList(completionHandler: completionHandler)
    }
}
