//
//  ContactsListViewController.swift
//  ContactsApp
//
//  Created by yahia samir on 15/07/2025.
//

import UIKit


class ContactsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var contacts: [Contact] = []
    var filteredContacts: [Contact] = []

    let titleLabel = UILabel()
    let searchBar = UISearchBar()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()

        contacts = ContactStorage.load()
        filteredContacts = contacts
    }

    func setupUI() {
        titleLabel.text = "Contacts"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        searchBar.placeholder = "Search Contacts"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        navigationItem.rightBarButtonItem = addButton

        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredContacts.isEmpty {
            let label = UILabel()
            label.text = "No contacts available."
            label.textAlignment = .center
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
        return filteredContacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: ContactCell.identifier)
        let contact = filteredContacts[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phone
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = ContactDetailViewController()
        detailVC.contact = filteredContacts[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedContact = filteredContacts[indexPath.row]
            contacts.removeAll { $0.name == deletedContact.name && $0.phone == deletedContact.phone }
            ContactStorage.save(contacts)
            updateSearchResults()
        }
    }

    @objc func addContact() {
        let addVC = AddContactViewController()
        addVC.onSave = { newContact in
            self.contacts.append(newContact)
            ContactStorage.save(self.contacts)
            self.updateSearchResults()
        }
        navigationController?.pushViewController(addVC, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults()
    }

    func updateSearchResults() {
        let text = searchBar.text?.lowercased() ?? ""
        if text.isEmpty {
            filteredContacts = contacts
        } else {
            filteredContacts = contacts.filter { $0.name.lowercased().contains(text) || $0.phone.contains(text) }
        }
        tableView.reloadData()
    }
}
