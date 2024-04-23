//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Chingiz on 19.04.2024.
//

import ProgressHUD
import UIKit

// MARK: - CatalogViewController

final class CatalogViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let catalogProvider: CatalogProvider = CatalogProviderImpl(networkClient: DefaultNetworkClient())
    private var catalogItems: [CatalogModel] = []
    
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
        return tableView
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
        // TODO: - Будет реализовано при выполнении задачи Catalog M1 Логика
        print("Будет реализовано при выполнении задачи Catalog M1 Логика")
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        [
            filterButton,
            catalogTableView
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
            catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchCollection() {
        ProgressHUD.show()
        catalogProvider.getCollection { [weak self] catalogItems in
            self?.catalogItems = catalogItems
            DispatchQueue.main.async {
                self?.catalogTableView.reloadData()
                ProgressHUD.dismiss()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
}

// MARK: - UITableViewDataSource

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatalogCell.reuseIdentifier, for: indexPath) as! CatalogCell
        let catalogItem = catalogItems[indexPath.row]
        cell.configure(with: catalogItem)
        cell.selectionStyle = .none
        cell.backgroundColor = .backgroundColorActive
        return cell
    }
}
