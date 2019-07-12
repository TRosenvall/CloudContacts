//
//  ContactDetailViewController.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // Our Contact landing pad from the segue.
    var contactLandingPad: Contact? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    // IB Outlets
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    
    // Pick the right keyboards for the right job.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactNumberTextField.keyboardType = UIKeyboardType.numberPad
        self.contactEmailTextField.keyboardType = UIKeyboardType.emailAddress
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        // Unwrap our outlets and make sure that the contactName isn't empty
        guard let contactName = contactNameTextField.text, !contactName.isEmpty,
            let contactNumber = contactNumberTextField.text,
            let contactEmail = contactEmailTextField.text
            else {return}
        // If we have a contact from segue, update the contact.
        if let contact = contactLandingPad {
            ContactController.sharedInstance.updateContact(contact: contact, contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail) { (success) in
                print("Contact successfully updated")
            }
        } else {
            // If we don't have a contact from segue, create a new one.
            ContactController.sharedInstance.createNewContact(contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail) { (success) in
                print("Contact Successfully Created and Saved to iCloud")
            }
            // Pop off the view and go back to the ContactListTableView
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // Update the views with the information passed in from the segue.
    func updateViews() {
        guard let contact = contactLandingPad else {return}
        contactNameTextField.text = contact.contactName
        contactNumberTextField.text = contact.contactNumber
        contactEmailTextField.text = contact.contactEmail
    }
}
