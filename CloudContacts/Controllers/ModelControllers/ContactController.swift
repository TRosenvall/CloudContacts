//
//  ContactController.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class ContactController {
    
    // Singleton
    static let sharedInstance = ContactController()
    
    // Source Of Truth
    var contacts: [Contact] = []
    
    // CRUD Functions
    // Create
    func createNewContact (contactName: String, contactNumber: String, contactEmail: String) {
        let contact = Contact(contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail)
        self.contacts.append(contact)
    }
    
    // Read
    
    // Update
    func updateContact (contact: Contact, contactName: String, contactNumber: String, contactEmail: String) {
        contact.contactName = contactName
        contact.contactNumber = contactNumber
        contact.contactEmail = contactEmail
    }
    
    // Delete
    
}
