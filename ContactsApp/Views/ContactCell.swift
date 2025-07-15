//
//  ContactCell.swift
//  ContactsApp
//
//  Created by yahia samir on 15/07/2025.
//

import UIKit


class ContactCell: UITableViewCell {
    static let identifier = "ContactCell"

    func configure(with contact: Contact) {
        textLabel?.text = contact.name
        detailTextLabel?.text = contact.phone
    }
}
