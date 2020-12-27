//
//  ChampionCell.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import SDWebImage
import UIKit

class ChampionCell: UICollectionViewCell {

    // MARK: - Properties

    var champion: Champion? {
        didSet { configure() }
    }

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        return lbl
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(profileImageView)
        profileImageView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 0)
        profileImageView.centerX(inView: contentView)
        profileImageView.setDimensions(height: 48, width: 48)

        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor,
                         bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                         paddingTop: 4,
                         paddingLeft: 4,
                         paddingBottom: 4,
                         paddingRight: 4)
        nameLabel.centerX(inView: contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configure() {
        guard let champion = champion else { return }

        let viewModel = ChampionViewModel(champion: champion)
        profileImageView.sd_setImage(with: viewModel.championIconURL)
        nameLabel.text = viewModel.championName
    }

}
