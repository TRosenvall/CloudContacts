//
//  ContactListTableViewController.swift
//  CloudContacts
//
//  Created by Timothy Rosenvall on 7/12/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.sharedInstance.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else {return UITableViewCell()}
        let contact = ContactController.sharedInstance.contacts[indexPath.row]
        cell.contact = contact
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Identifier
        if segue.identifier == "toEditDetailView" {
            //Index and Destination
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? ContactDetailViewController else {return}
            //Object to Send
            let contact = ContactController.sharedInstance.contacts[indexPath.row]
            //Object to Set
            destinationVC.contactLandingPad = contact
        }
    }
}
