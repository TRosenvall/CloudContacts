//
//  Contact.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    // Properties
    var contactName: String
    var contactNumber: String
    var contactEmail: String
    
    // CloudKit Properties
    let recordID: CKRecord.ID
    
    // Basic Initializer
    init(contactName: String, contactNumber: String, contactEmail: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.contactName = contactName
        self.contactNumber = contactNumber
        self.contactEmail = contactEmail
        self.recordID = recordID
    }
}

extension Contact {
    // Convenience Initializer to convert a CloudKit record into a Contact
    convenience init?(record: CKRecord) {
        // Pulling the different Contact properties from the record
        guard let contactName = record[ContactConstants.contactNameTypeKey] as? String,
            let contactNumber = record[ContactConstants.contactNumberTypeKey] as? String,
            let contactEmail = record[ContactConstants.contactEmailTypeKey] as? String
            else {return nil}
        // Creating a contact from the CloudKit Record
        self.init(contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail, recordID: record.recordID)
    }
}

extension CKRecord {
    // Create a CloudKit record out of a Contact.
    convenience init(contact: Contact) {
        self.init(recordType: ContactConstants.contactTypeKey, recordID: contact.recordID)
        self.setValue(contact.contactName, forKey: ContactConstants.contactNameTypeKey)
        self.setValue(contact.contactNumber, forKey: ContactConstants.contactNumberTypeKey)
        self.setValue(contact.contactEmail, forKey: ContactConstants.contactEmailTypeKey)
    }
}

// Plaving the type keys in a constants struct for safety.
struct ContactConstants {
    static let contactTypeKey: String = "Contact"
    fileprivate static let contactNameTypeKey: String = "contactName"
    fileprivate static let contactNumberTypeKey: String = "contactNumber"
    fileprivate static let contactEmailTypeKey: String = "contactEmail"
}
