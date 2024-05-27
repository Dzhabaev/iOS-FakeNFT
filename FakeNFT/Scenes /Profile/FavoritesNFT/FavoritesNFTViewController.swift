//
//  FavoritesNFTViewController.swift
//  FakeNFT
//
//  Created by Chalkov on 19.05.2024.
//

import UIKit
import ProgressHUD

protocol FavoritesNFTViewControllerProtocol {
    
    var presenter: FavoritesNFTPresenterProtocol? { get set }
    
    func updateUI()
    func showViewController(_ vc: UIViewController)
    func showEmptyCart()
    func showProgressHUB()
    func dismissProgressHUB()
    
    func showAlertController(_ error: Error)
}

final class FavoritesNFTViewController: UIViewController, FavoritesNFTViewControllerProtocol {

    var presenter: FavoritesNFTPresenterProtocol?
    
    private var alertComponent = AlertComponent()

    private lazy var backButton = UIBarButtonItem(
        image: UIImage(named: "BackBttnCart"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "У вас еще нет избранных NFT"
        emptyLabel.font = .bodyBold
        emptyLabel.textColor = .black
        return emptyLabel
    }()
    
    private lazy var favoriteNFTCollection: UICollectionView = {
        let favoriteNFTCollection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        favoriteNFTCollection.translatesAutoresizingMaskIntoConstraints = false
        favoriteNFTCollection.register(FavoritesCell.self)
        favoriteNFTCollection.backgroundColor = .white
        favoriteNFTCollection.dataSource = self
        favoriteNFTCollection.delegate = self
        return favoriteNFTCollection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
        setupCollectionView()
        presenter?.viewDidLoad()
    }

    private func setupCollectionView() {
        view.addSubview(favoriteNFTCollection)
        
        NSLayoutConstraint.activate([
            favoriteNFTCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteNFTCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteNFTCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteNFTCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func updateUI() {
        favoriteNFTCollection.reloadSections(IndexSet(integer: 0))
    }
    
    func showProgressHUB() {
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorAnimation = .black
        ProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        ProgressHUD.dismiss()
    }
    
    func showViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showAlertController(_ error: Error) {
        dismissProgressHUB()
        let alert = alertComponent.makeErrorAlert(error.localizedDescription)
        present(alert, animated: true)
    }
    
    func showEmptyCart() {
        favoriteNFTCollection.isHidden = true
        emptyLabel.isHidden = false
        navigationItem.title = ""
    }
    
    private func setupNavBar() {
        navigationItem.title = "Избранные NFT"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(emptyLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - FavoritesCellDelegate

extension FavoritesNFTViewController: FavoritesCellDelegate {
    func dislikeButtonTapped(at indexPath: IndexPath) {
        presenter?.dislikeButtonTapped(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension FavoritesNFTViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FavoritesCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        
        guard let presenter else { return UICollectionViewCell() }
        
        cell.update(presenter.cellForItem(at: indexPath))
        cell.currentIndexPath = indexPath
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesNFTViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 16 * 2 - 7
        return CGSize(width: availableWidth / 2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    }
    
}
