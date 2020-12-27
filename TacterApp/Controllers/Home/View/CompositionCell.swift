//
//  CompositionCell.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import SDWebImage
import UIKit

class CompositionCell: UITableViewCell {

    // MARK: - Properties

    var composition: Composition? {
        didSet { configure() }
    }

    private var stack: UIStackView = UIStackView()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configureUI() {
        contentView.backgroundColor = .black

        contentView.addSubview(stack)
        stack.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                     left: contentView.safeAreaLayoutGuide.leftAnchor,
                     right: contentView.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 4,
                     paddingLeft: 16,
                     paddingRight: 16)
        stack.setHeight(height: 60)
    }

    private func configure() {
        // TODO Use ViewModel here!
        guard let composition = composition else { return }
        stack = HomeFactory.shared.createCustomViews(for: composition)
        configureUI()
    }
}
