//
//  TeamBuilderView.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

class TeamBuilderView: UIViewController {

    // MARK: - Properties

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Save", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.tacterYellow, for: .normal)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: BARBUTTON_STANDARD_SIZE.width * 2,
                              height: BARBUTTON_STANDARD_SIZE.height)
        button.addTarget(self, action: #selector(handleSaveComposition), for: .touchUpInside)

        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .darkGray
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: BARBUTTON_STANDARD_SIZE.width,
                              height: BARBUTTON_STANDARD_SIZE.height)
        button.addTarget(self, action: #selector(handleCancelComposition), for: .touchUpInside)

        return button
    }()

    private let viewModel: TeamBuilderViewModel
    private var champions = [Champion]()

    // MARK: - Lifecycle

    init(viewModel: TeamBuilderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getChampionsList()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Team builder", prefersLargeTitles: false)
    }

    // MARK: - Selectors

    @objc func handleSaveComposition() {
        print("SAVE!")
    }

    @objc func handleCancelComposition() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - API

    private func getChampionsList() {
        DispatchQueue.main.async {
            self.showLoader(true)
        }
        viewModel.getChampionsList { [weak self] champions in
            guard let strongSelf = self else { return }

            DispatchQueue.main.async {
                strongSelf.showLoader(false)
            }
            guard let champions = champions else {
                strongSelf.showError("Call to server failed")
                return
            }

            strongSelf.champions = champions
            print("championID: \(champions[0].championId)")
        }
    }

    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .red

        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
