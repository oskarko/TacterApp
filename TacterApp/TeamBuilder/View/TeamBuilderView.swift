//
//  TeamBuilderView.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

class TeamBuilderView: UIViewController {

    // MARK: - Properties

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

    // MARK: - Selectors

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

    }
}
