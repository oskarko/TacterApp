//
//  TeamBuilderViewModel.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import Foundation

struct TeamBuilderViewModel {
    // MARK: - Properties
    
    let actionButtonTitle: String = "Save"

    // MARK: - API
    
    func getChampionsList(completionHandler: @escaping ([Champion]?) -> Void) {
        ManagerServices.shared.getChampionsList(completionHandler: completionHandler)
    }
}
