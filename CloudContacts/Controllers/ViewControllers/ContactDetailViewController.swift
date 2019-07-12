//
//  ContactDetailViewController.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contactLandingPad: Contact? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactNumberTextField.keyboardType = UIKeyboardType.numberPad
        self.contactEmailTextField.keyboardType = UIKeyboardType.emailAddress
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard var contactName = contactNameTextField.text,
            let contactNumber = contactNumberTextField.text,
            let contactEmail = contactEmailTextField.text
            else {return}
        
        if !contactName.isEmpty || !contactNumber.isEmpty || !contactEmail.isEmpty {
            if let contact = contactLandingPad {
                ContactController.sharedInstance.updateContact(contact: contact, contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail)
            } else {
                if contactName == "" {
                    contactName = "Unknown"
                }
                ContactController.sharedInstance.createNewContact(contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let contact = contactLandingPad else {return}
        contactNameTextField.text = contact.contactName
        contactNumberTextField.text = contact.contactNumber
        contactEmailTextField.text = contact.contactEmail
    }
}
