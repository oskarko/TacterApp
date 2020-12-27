//
//  TeamBuilderFactory.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

class TeamBuilderFactory {
    static let shared = TeamBuilderFactory()

    func createCustomViews(rows: Int, viewsPerRow: Int) -> UIStackView {
        var subCustomStacks = [UIStackView]()

        for i in 0..<rows {
            var subCustomViews = [ChampionCustomView]()

            for j in 0..<viewsPerRow {
                subCustomViews.append(generateCustomView(tag: (i * viewsPerRow) + j))
            }
            let subStack = UIStackView(arrangedSubviews: subCustomViews)
            subStack.axis = .horizontal
            subStack.spacing = 16
            subStack.distribution = .equalCentering

            subCustomStacks.append(subStack)
        }

        let stack = UIStackView(arrangedSubviews: subCustomStacks)
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalCentering

        return stack
    }

    private func generateCustomView(tag: Int) -> ChampionCustomView {
        let view = ChampionCustomView(tag: tag)
        return view
    }

    @objc func handleTap(gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }

        NotificationCenter.default.post(name: .didChampionCustomViewTap,
                                        object: nil,
                                        userInfo: ["tag": view.tag])
    }
}
