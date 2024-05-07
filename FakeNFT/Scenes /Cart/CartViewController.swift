//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Chingiz on 19.04.2024.
//

import UIKit
import ProgressHUD

protocol CartViewControllerProtocol: AnyObject {
    var presenter: CartPresenterProtocol? { get set }
    func updateTable()
    func startLoading()
    func stopLoading()
    func showEmptyMessage()
    func hideEmptyMessage()
}

final class CartViewController: UIViewController & CartViewControllerProtocol {

    var presenter: CartPresenterProtocol? = CartPresenter(networkClient: DefaultNetworkClient())
    private let refreshControl = UIRefreshControl()

    private let sortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "SortButton.png")?.withTintColor(.blackDayText)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(sortBttnTapped), for: .touchUpInside)
        return button
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.alwaysBounceVertical = true
        table.register(CustomCellViewCart.self, forCellReuseIdentifier: CustomCellViewCart.reuseIdentifier)
        return table
    }()

    private let priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .segmentInactive
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 12
        return view
    }()

    private let payButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Cart.payBttn", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = UIColor(named: "blackDayNight")
        button.layer.cornerRadius = 16
        button.setTitleColor(.backgroundColor, for: .normal)
        button.addTarget(self, action: #selector(payBttnTapped), for: .touchUpInside)
        return button
    }()

    private let valueNft: UILabel = {
        let label = UILabel()
        label.text = "3 NFT"
        label.textColor = UIColor(named: "blackDayNight")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private let priceNfts: UILabel = {
        let label = UILabel()
        label.text = "5,34 ETH"
        label.textColor = .greenUniversal
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    private let priceStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 2
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина пуста"
        label.textColor = UIColor(named: "blackDayNight")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    @objc private func sortBttnTapped() {
        let byPrice = NSLocalizedString("Cart.sortByPrice", comment: "")
        let byName = NSLocalizedString("Cart.sortByName", comment: "")
        let byRating = NSLocalizedString("Cart.sortByRating", comment: "")
        let alert = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: byPrice, style: .default, handler: { [weak self] _ in
            UserDefaults.standard.set("byPrice", forKey: "CartSorted")
            self?.presenter?.sortCatalog()
        }))
        alert.addAction(UIAlertAction(title: byName, style: .default, handler: { [weak self] _ in
            UserDefaults.standard.set("byName", forKey: "CartSorted")
            self?.presenter?.sortCatalog()
        }))
        alert.addAction(UIAlertAction(title: byRating, style: .default, handler: { [weak self] _ in
            UserDefaults.standard.set("byRating", forKey: "CartSorted")
            self?.presenter?.sortCatalog()
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

    @objc private func payBttnTapped() {
        let payPage = CartPayViewController()
        let navigationController = UINavigationController(rootViewController: payPage)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }

    @objc
    private func didPullToRefresh(_ sender: Any) {
        presenter?.getAllCartData()
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        configureView()
        configureConstraits()
        showEmptyMessage()
        presenter?.getAllCartData()
        updateTable()
    }

    private func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        [tableView,
         sortButton,
         priceView,
         emptyLabel].forEach {
            view.addSubview($0)
        }
        [valueNft,
         priceNfts].forEach {
            priceStack.addArrangedSubview($0)
        }
        [priceStack,
         payButton].forEach {
            priceView.addSubview($0)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureConstraits() {
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.widthAnchor.constraint(equalToConstant: 42),

            tableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: priceView.topAnchor),

            priceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            priceView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            priceStack.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 16),
            priceStack.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 16),
            priceStack.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -16),

            payButton.leadingAnchor.constraint(equalTo: priceStack.trailingAnchor, constant: 24),
            payButton.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 16),
            payButton.bottomAnchor.constraint(equalTo: payButton.bottomAnchor, constant: -16),
            payButton.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -16),
            payButton.widthAnchor.constraint(equalToConstant: 240),
            payButton.heightAnchor.constraint(equalToConstant: 44),

            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func showEmptyMessage() {
        emptyLabel.isHidden = false
    }

    func hideEmptyMessage() {
        emptyLabel.isHidden = true
    }

    func updateTable() {
        tableView.reloadData()
    }

    func startLoading() {
        ProgressHUD.show()
    }

    func stopLoading() {
        ProgressHUD.dismiss()
    }
}

extension CartViewController: UITableViewDelegate {

}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.visibleNft.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellViewCart.reuseIdentifier,
                                for: indexPath) as? CustomCellViewCart else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.delegate = self
        guard let data = presenter?.visibleNft[indexPath.row] else { return UITableViewCell()}
        cell.initCell(nameLabel: data.name, priceLabel: data.price, rating: data.rating, nftId: data.id)
        return cell
    }
}

extension CartViewController: CustomCellViewCartDelegate {
    func cellDidTapDeleteCart(nftId: String) {
        let deleteNft = CartDeleteConfirmView()
        deleteNft.nftId = nftId
        deleteNft.delegate = self
        let navigationController = UINavigationController(rootViewController: deleteNft)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
}

extension CartViewController: CartDeleteConfirmDelegate {
    func deleteNftCart(nftId: String) {
        presenter?.editOrder(typeOfEdit: .deleteNft, nftId: nftId)
    }
}
