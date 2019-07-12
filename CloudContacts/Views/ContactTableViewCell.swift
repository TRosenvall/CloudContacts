//
//  ContactTableViewCell.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // Setting a base Contact property in the cell to follow MVC
    var contact: Contact? {
        didSet {
            // Calling the views of the custom cell to update when a Contact is passed into it.
            updateViews()
        }
    }
    
    // IBOutlets
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    // Function to update the IBOutlets in the cell.
    func updateViews () {
        // Unwrap the contact passed into the cell.
        guard let contact = contact else {return}
        // Set the labels.
        contactNameLabel.text = contact.contactName
        contactNumberLabel.text = contact.contactNumber
        contactEmailLabel.text = contact.contactEmail
    }
}
