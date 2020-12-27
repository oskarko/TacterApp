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
        var subCustomStacks = [UIView]()

        for i in 0..<rows {
            var subCustomViews = [UIView]()

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

    private func generateCustomView(tag: Int) -> UIView {
        let view = UIView()
        view.tag = tag
        view.backgroundColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = (tag == 0 ? UIColor.tacterYellow : UIColor.black).cgColor
        view.layer.cornerRadius = 9
        view.setDimensions(height: 54, width: 54)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.darkGray.cgColor
        iv.layer.cornerRadius = 8
        iv.setDimensions(height: 48, width: 48)

        view.addSubview(iv)
        iv.centerX(inView: view)
        iv.centerY(inView: view)

        return view
    }

    @objc func handleTap(gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }

        NotificationCenter.default.post(name: .didChampionCustomViewTap,
                                        object: nil,
                                        userInfo: ["tag": view.tag])
    }
}
