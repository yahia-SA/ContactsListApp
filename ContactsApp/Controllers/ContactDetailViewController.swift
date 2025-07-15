//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by yahia samir on 15/07/2025.
//

import UIKit


class ContactDetailViewController: UIViewController {
    var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Details"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor.black
        ]

        view.backgroundColor = .white

        guard let contact = contact else { return }

        let nameLabel = UILabel()
        nameLabel.text = "Name: \(contact.name)"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        let phoneLabel = UILabel()
        phoneLabel.text = "Phone: \(contact.phone)"
        phoneLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [nameLabel, phoneLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
