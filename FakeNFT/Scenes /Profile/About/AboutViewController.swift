//
//  AboutViewController.swift
//  FakeNFT
//
//  Created by Chalkov on 20.05.2024.
//

import UIKit

final class AboutViewController: UIViewController {

    private lazy var backButton = UIBarButtonItem(
        image: UIImage(named: "BackBttnCart"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "Это 12 когорта"
        emptyLabel.font = .headline2
        emptyLabel.textColor = .black
        return emptyLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setConstraints()
    }

    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "О разработчике"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(emptyLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
