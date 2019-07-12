//
//  ContactController.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    // Singleton
    static let sharedInstance = ContactController()
    
    // Cloud Database - Private Database so everyone has access to only their own contacts.
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // Source Of Truth
    var contacts: [Contact] = []
    
    // CRUD Functions
    // Create
    func createNewContact (contactName: String, contactNumber: String, contactEmail: String, completion: @escaping (Bool) -> Void) {
        // Initialize a Contact from the properties passed into the function.
        let contact = Contact(contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail)
        // Create a CloudKit record from the Contact
        let record = CKRecord(contact: contact)
        // Save to iCloud
        privateDB.save(record) { (_, error) in
            // Error Handling
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            } else {
                // If saving to iCloud is successful, append the contact to the source of truth and call completion.
                self.contacts.append(contact)
                completion(true)
            }
        }
    }
    
    // Read
    // Fetch Contacts from iCloud
    func fetchContacts (completion: @escaping (Bool) -> Void ) {
        // Set a predicate and query item
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactConstants.contactTypeKey, predicate: predicate)
        // Perform the fetch
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            // Error handling
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            // Update the contacts from iCloud and call completion.
            } else if let records = records {
                // Unwrap the records and reset the source of truth.
                let contacts = records.compactMap( {Contact(record: $0)} )
                self.contacts = contacts
                completion(true)
            }
        }
    }
    
    // Update
    func updateContact (contact: Contact, contactName: String, contactNumber: String, contactEmail: String, completion: @escaping (Bool) -> Void) {
        // Update the contact passed into the function.
        contact.contactName = contactName
        contact.contactNumber = contactNumber
        contact.contactEmail = contactEmail
        // Create a record to be updated.
        let record = CKRecord(contact: contact)
        // Call the modification operation function for iCloud.
        update(record: record, database: privateDB) { (success) in
            if success {
                // Complete as true if successful.
                print("Successfully updated on iCloud")
                completion(true)
            }
        }
    }
    
    // Update the record on iCloud
    func update(record: CKRecord, database: CKDatabase, completion: @escaping(Bool) -> Void) {
        // Create an operation and set it's properties
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            // When the operation is finished, call for completion.
            completion(true)
        }
        // Call the operation on the database.
        database.add(operation)
    }
    // Delete
    
}
