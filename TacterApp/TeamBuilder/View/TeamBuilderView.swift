//
//  TeamBuilderView.swift
//  TacterApp
//
//  Created by Oscar Rodriguez Garrucho on 27/12/20.
//

import UIKit

private let reuseIdentifier = "ChampionCell"

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

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        return collection
    }()

    private let viewModel: TeamBuilderViewModel
    private var champions = [Champion]()
    private var selectedChampions = [Champion](repeating: Champion(), count: 2 * 5)
    private var selectedCustomViewTag: Int = 0
    private lazy var stack: UIStackView = TeamBuilderFactory.shared.createCustomViews(rows: 2,
                                                                                      viewsPerRow: 5)

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onDidChampionCustomViewTap(_:)),
                                               name: .didChampionCustomViewTap,
                                               object: nil)

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

    @objc func onDidChampionCustomViewTap(_ notification:Notification) {
        guard let userInfo = notification.userInfo,
              let tag = userInfo["tag"] as? Int else { return }
        selectedCustomViewTag = tag
        changeSelectedChampionCustomView()
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
            DispatchQueue.main.async {
                strongSelf.collectionView.reloadData()
            }
        }
    }

    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .black

        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)

        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 16,
                     paddingLeft: 16,
                     paddingRight: 16)
        stack.setHeight(height: 140)

        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ChampionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive

        view.addSubview(collectionView)
        collectionView.anchor(top: stack.bottomAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: 16,
                              paddingLeft: 16,
                              paddingBottom: 16,
                              paddingRight: 16)
    }

    private func changeSelectedChampionCustomView() {
//        for arrangedSubview in stack.arrangedSubviews {
//            guard let subStack = arrangedSubview as? UIStackView else { return }
//
//            for arrangedView in subStack.arrangedSubviews {
////                guard let customView = arrangedView as? ChampionCustomView else { return }
//                print("... \(arrangedView.tag) and selectedtag: \(selectedCustomViewTag)")
//                arrangedView.layer.borderColor = (arrangedView.tag == selectedCustomViewTag ?
//                        UIColor.tacterYellow : UIColor.black).cgColor
//
//                let isIndexValid = selectedChampions.indices.contains(arrangedView.tag)
//                guard isIndexValid else { return }
//
//                guard let iconURL = selectedChampions[arrangedView.tag].iconURL else { return }
//
//                guard let customView = arrangedView as? ChampionCustomView else { return }
//
//                let url = URL(string: iconURL)
//                customView.imageView.sd_setImage(with: url, completed: nil)
//            }
//        }
        for arrangedSubview in stack.arrangedSubviews {
            guard let subStack = arrangedSubview as? UIStackView else { return }

            for arrangedView in subStack.arrangedSubviews {
                print("... \(arrangedView.tag) and selectedtag: \(selectedCustomViewTag)")
                arrangedView.layer.borderColor = (arrangedView.tag == selectedCustomViewTag ?
                                                    UIColor.tacterYellow : UIColor.black).cgColor

                let isIndexValid = selectedChampions.indices.contains(arrangedView.tag)
                guard isIndexValid else { return }

                guard let iconURL = selectedChampions[arrangedView.tag].iconURL else { return }

                guard let customView = arrangedView as? ChampionCustomView else { return }

                let url = URL(string: iconURL)
                customView.imageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension TeamBuilderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedChampion = champions[indexPath.row]
        if selectedChampions.count > selectedCustomViewTag {
            selectedChampions.remove(at: selectedCustomViewTag)
        }

        selectedChampions.insert(selectedChampion, at: selectedCustomViewTag)
        changeSelectedChampionCustomView()
    }
}

// MARK: - UICollectionViewDataSource

extension TeamBuilderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChampionCell
        cell.champion = champions[indexPath.row]

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TeamBuilderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return .init(width: 50, height: 80)
    }

    // Padding for the collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 48, left: 8, bottom: 0, right: 8)
    }
}
