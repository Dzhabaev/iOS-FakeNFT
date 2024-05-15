//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Chalkov on 13.05.2024.
//

import UIKit
import ProgressHUD

protocol MyNFTViewControllerProtocol: AnyObject {
    var presenter: MyNFTPresenterProtocol? { get set }
    
    func updateUI()
    func navigateToSortAlert(_ vc: UIViewController)
    func showEmptyCart()
    func showProgressHUB()
    func dismissProgressHUB()
}

final class MyNFTViewController: UIViewController {

    var presenter: MyNFTPresenterProtocol?
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(named: "back"),
        style: .plain,
        target: self,
        action: #selector(backButtonTapped)
    )
    
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage(named: "sort"),
        style: .plain,
        target: self,
        action: #selector(sortButtonTapped)
    )
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyNFTCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "У вас еще нет NFT"
        emptyLabel.font = .bodyBold
        emptyLabel.textColor = .black
        emptyLabel.isHidden = true
        return emptyLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupViews()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = sortButton
        navigationItem.title = "Мои NFT"
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func sortButtonTapped() {
        presenter?.sortButtonTapped()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension MyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = presenter?.cellForRow(at: indexPath) else { return UITableViewCell() }
        cell.currentIndexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - UITableViewDelegate

extension MyNFTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MyNFTViewControllerProtocol

extension MyNFTViewController: MyNFTViewControllerProtocol {
    
    func updateUI() {
        tableView.reloadSections(
            IndexSet(integer: 0), with: .automatic
        )
    }
    
    func navigateToSortAlert(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showEmptyCart() {
        tableView.isHidden = true
        emptyLabel.isHidden = false
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = nil
    }
    
    func showProgressHUB() {
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorAnimation = .black
        ProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        ProgressHUD.dismiss()
    }
}
