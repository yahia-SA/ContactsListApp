//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by yahia samir on 15/07/2025.
//

import UIKit


class AddContactViewController: UIViewController {
    var onSave: ((Contact) -> Void)?
    let nameField = UITextField()
    let phoneField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Contact"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.black
        ]

        view.backgroundColor = .white

        nameField.placeholder = "Name"
        phoneField.placeholder = "Phone"
        nameField.borderStyle = .roundedRect
        phoneField.borderStyle = .roundedRect

        let stackView = UIStackView(arrangedSubviews: [nameField, phoneField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveContact), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func saveContact() {
        guard let name = nameField.text, !name.isEmpty,
              let phone = phoneField.text, !phone.isEmpty else { return }
        let contact = Contact(name: name, phone: phone)
        onSave?(contact)
        navigationController?.popViewController(animated: true)
    }
}
