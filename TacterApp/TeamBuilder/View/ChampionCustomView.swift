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
        iv.setDimensions(height: 48, width: 48)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(handleTap)))

        return iv
    }()

    // MARK: - Lifecycle

    init(tag: Int) {
        super.init(frame: .zero)
        self.tag = tag
        backgroundColor = .black

        layer.borderWidth = 2
        layer.borderColor = (tag == 0 ? UIColor.tacterYellow : UIColor.black).cgColor
        layer.cornerRadius = 9
        setDimensions(height: 54, width: 54)

        addSubview(imageView)
        imageView.centerX(inView: self)
        imageView.centerY(inView: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc func handleTap(gesture: UITapGestureRecognizer) {
        print("tap tap \(tag)")
        NotificationCenter.default.post(name: .didChampionCustomViewTap,
                                        object: nil,
                                        userInfo: ["tag": tag])
    }
}
