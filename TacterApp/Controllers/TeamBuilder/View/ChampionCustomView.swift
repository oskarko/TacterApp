//
//  ChampionCustomView.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

class ChampionCustomView: UIView {

    // MARK: - Properties

    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.darkGray.cgColor
        iv.layer.cornerRadius = 8
        iv.setDimensions(height: (height / 6 ) * 5, width: (width / 6 ) * 5)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(handleTap)))

        return iv
    }()

    var champion: Champion? {
        didSet { configure() }
    }

    private var height: CGFloat = 0
    private var width: CGFloat = 0

    // MARK: - Lifecycle

    init(tag: Int, height: CGFloat = 54, width: CGFloat = 54) {
        super.init(frame: .zero)
        self.tag = tag
        self.height = height
        self.width = width

        backgroundColor = .black
        layer.borderWidth = 2
        layer.borderColor = (tag == 0 ? UIColor.tacterYellow : UIColor.black).cgColor
        layer.cornerRadius = height / 6

        setDimensions(height: height, width: height)

        addSubview(imageView)
        imageView.centerX(inView: self)
        imageView.centerY(inView: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configure() {
        guard let champion = champion else { return }

        imageView.isHidden = champion.championId == -1

        guard let iconURL = champion.iconURL,
              let url = URL(string: iconURL) else { return }

        imageView.sd_setImage(with: url)
    }

    // MARK: - Selectors

    @objc func handleTap(gesture: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .didChampionCustomViewTap,
                                        object: nil,
                                        userInfo: ["tag": tag])
    }
}
