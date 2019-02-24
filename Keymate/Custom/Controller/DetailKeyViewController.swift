//
//  DetailKeyViewController.swift
//  Keymate
//
//  Created by Nora Wokatsch on 05.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailKeyViewController: BaseTableViewController, UITextFieldDelegate, UIPickerViewDelegate, NSFetchedResultsControllerDelegate {
    
    var key: Key?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.favSwitch.isUserInteractionEnabled = false
        self.tableView.allowsSelection = false
        
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        
        nameLabel.text = key?.name
        passwordLabel.text = key?.password
        categoryLabel.text = key?.category
        favSwitch.isOn = (key?.fav)!
        notesLabel.text = key?.note
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var favSwitch: UISwitch!
    @IBOutlet weak var notesLabel: UILabel!
}
