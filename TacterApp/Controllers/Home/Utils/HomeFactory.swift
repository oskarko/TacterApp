//
//  HomeFactory.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

/// Helper class to generate dynamic views to insert directly in our collectionview or cells.
class HomeFactory {
    static let shared = HomeFactory()

    func createCustomViews(for composition: Composition) -> UIStackView {

        var subCustomViews = [ChampionCustomView]()
        var emptyView = [ChampionCustomView]()

        for i in 0..<composition.listOfChampions.count {
            // sort empty champions
            if composition.listOfChampions[i].championId == -1 {
                emptyView.append(generateCustomView(tag: -1, champion: composition.listOfChampions[i]))
                continue
            }
            subCustomViews.append(generateCustomView(tag: -1, champion: composition.listOfChampions[i]))
        }
        subCustomViews.append(contentsOf: emptyView)

        let stack = UIStackView(arrangedSubviews: subCustomViews)
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .equalCentering

        return stack
    }

    // This method MUST BE REFACTORED.
    private func generateCustomView(tag: Int, champion: Champion) -> ChampionCustomView {
        let view = ChampionCustomView(tag: tag, height: 36, width: 36)
        view.champion = champion
        return view
    }
}
