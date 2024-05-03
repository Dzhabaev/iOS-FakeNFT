//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Chingiz on 19.04.2024.
//

import UIKit

// MARK: - CatalogViewController

final class CatalogViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter = CatalogPresenter()
    private var catalogItems: [CatalogModel] = []
    private var sortType: SortType = .none
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sort")?.withTintColor(.segmentActive), for: .normal)
        button.addTarget(self, action: #selector(tapFiltersButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var catalogTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundColorActive
        tableView.register(
            CatalogCell.self,
            forCellReuseIdentifier: CatalogCell.reuseIdentifier
        )
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .segmentActive
        refreshControl.addTarget(self, action: #selector(refreshCatalog), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        fetchCollection()
    }
    
    // MARK: - Actions
    
    @objc
    private func tapFiltersButton() {
        let action = UIAlertController(
            title: NSLocalizedString("alert.sorting", comment: ""),
            message: nil,
            preferredStyle: .actionSheet
        )
        
        action.addAction(UIAlertAction(
            title: NSLocalizedString("alert.byName", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.sortType = .byName
                self?.sortCatalog()
            }
        ))
        
        action.addAction(UIAlertAction(
            title: NSLocalizedString("alert.byQuantity", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.sortType = .byQuantity
                self?.sortCatalog()
            }
        ))
        
        action.addAction(UIAlertAction(
            title: NSLocalizedString("alert.close", comment: ""),
            style: .cancel
        ))
        
        self.present(action, animated: true)
    }
    
    @objc private func refreshCatalog() {
        fetchCollection()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        [
            filterButton,
            catalogTableView,
            loadingIndicator
        ]
            .forEach {
                subview in
                view.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            filterButton.heightAnchor.constraint(equalToConstant: 42),
            filterButton.widthAnchor.constraint(equalToConstant: 42),
            
            catalogTableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            catalogTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catalogTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchCollection() {
        if !refreshControl.isRefreshing {
            loadingIndicator.startAnimating()
        }
        presenter.fetchCollectionAndUpdate { [weak self] catalogItems in
            self?.loadingIndicator.stopAnimating()
            guard let self = self else { return }
            self.catalogItems = catalogItems
            self.catalogTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func sortCatalog() {
        catalogItems = presenter.sortCatalog(by: sortType)
        catalogTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let collectionDetailsVC = CollectionDetailsViewController()
        collectionDetailsVC.modalPresentationStyle = .fullScreen
        present(collectionDetailsVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogCell.reuseIdentifier, for: indexPath) as? CatalogCell else {
            return UITableViewCell()
        }
        let catalogItem = catalogItems[indexPath.row]
        cell.configure(with: catalogItem, imageLoader: CatalogProviderImpl(networkClient: DefaultNetworkClient()))
        cell.selectionStyle = .none
        cell.backgroundColor = .backgroundColorActive
        return cell
    }
}
