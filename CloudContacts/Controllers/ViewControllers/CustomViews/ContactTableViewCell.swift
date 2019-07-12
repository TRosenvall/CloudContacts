//
//  ContactTableViewCell.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var contact: Contact? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    func updateViews () {
        guard let contact = contact else {return}
        contactNameLabel.text = contact.contactName
        contactNumberLabel.text = contact.contactNumber
        contactEmailLabel.text = contact.contactEmail
    }
}
