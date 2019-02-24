//
//  OverviewController.swift
//  Keymate
//
//  Created by Laureen Schausberger on 01.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class OverviewController: BaseTableViewController, NSFetchedResultsControllerDelegate {

    let cdManager: CoreDataManager = CoreDataManager.sharedInstance
    var keys: [Key] = []
    var sorted: [Key] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateObjects),
            name: Notification.Name.NSManagedObjectContextDidSave,
            object: nil
        )
        self.updateViewData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateViewData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overViewCell", for: indexPath)
        let key = Array(sorted)[indexPath.row]
        
        
        let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView
        let nameLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let catLabel: UILabel = cell.viewWithTag(3) as! UILabel
    
        nameLabel.text = key.name
        catLabel.text = key.category
        
        if key.category == "Login" {
            imageView.image = UIImage(named: "loginImage")
        }
        if key.category == "Bankaccount" {
            imageView.image = UIImage(named: "bankImage")
        }
        if key.category == "Personal" {
            imageView.image = UIImage(named: "personalImage")
        }
        if key.category == "Other" {
            imageView.image = UIImage(named: "othersImage")
        }
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let viewcontroller = segue.destination as! DetailKeyViewController
            viewcontroller.key = Array(sorted)[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // MARK: DataSource
    func updateObjects(notification: Notification) {
        self.fetchedResultsController.managedObjectContext.mergeChanges(fromContextDidSave: notification)
        updateViewData()
        self.updateViewData()
        self.tableView.reloadData()
    }
    
    func updateViewData() {
        keys = Key.fetchInContext(cdManager.managedObjectContext)
        if keys != nil {
            sorted = keys.sorted { $0.name! < $1.name! }
        }
        
    }
    
    // - MARK: NSFetchedResultController
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Key> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Key> = Key.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "abc", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath as IndexPath], with: .fade)
                print("got something")
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            }
            break
            
        default:
            break
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = self.tableView.cellForRow(at: indexPath)
            let label = cell?.viewWithTag(2) as! UILabel
            if let name = label.text {
                var i = 0
                for key in sorted {
                    i += 1
                    if key.name == name {
                        if i == 1 {
                            sorted.removeFirst()
                        } else {
                            sorted.remove(at: i)
                        }
                        _ = Key.delete(key: key, in: CoreDataManager.sharedInstance.managedObjectContext)
                        self.updateViewData()
                    }
                }
            }
        }
    }
}
