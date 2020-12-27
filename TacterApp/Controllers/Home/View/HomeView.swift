//
//  HomeView.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

private let reuseIdentifier = "CompositionCell"

class HomeView: UITableViewController {

    // MARK: - Properties

    private let viewModel: HomeViewModel
    private var compositions = [Composition]()

    private let newCompositionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .tacterYellow
        button.tintColor = .white
        button.imageView?.setDimensions(height: FLOAT_BUTTON_IMAGE_HEIGHT,
                                        width: FLOAT_BUTTON_IMAGE_WIDTH)
        button.addTarget(self, action: #selector(showNewComposition), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "My comps", prefersLargeTitles: false)

        compositions = viewModel.getCompositions()
        tableView.reloadData()
    }

    // MARK: - Selectors

    @objc func showNewComposition() {
        // TODO Use Router/Coordinator here!
        let viewModel = TeamBuilderViewModel()
        let controller = TeamBuilderView(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }

    // MARK: - Helpers

    private func configureUI() {
        configureTableView()

        view.addSubview(newCompositionButton)
        newCompositionButton.setDimensions(height: FLOAT_BUTTON_HEIGHT,
                                           width: FLOAT_BUTTON_WIDTH)
        newCompositionButton.layer.cornerRadius = FLOAT_BUTTON_HEIGHT / 2
        newCompositionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.safeAreaLayoutGuide.rightAnchor,
                                paddingBottom: FLOAT_BUTTON_PADDING_BOTTOM,
                                paddingRight: FLOAT_BUTTON_PADDING_RIGHT)
    }

    private func configureTableView() {
        tableView.backgroundColor = .black
        tableView.rowHeight = HOME_TABLEVIEW_ROW_HEIGHT
        tableView.register(CompositionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.frame = view.frame
    }
}

// MARK: - UITableViewDataSource

extension HomeView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compositions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CompositionCell
        cell.composition = compositions[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeView {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
        // Show Details view.
    }
}
