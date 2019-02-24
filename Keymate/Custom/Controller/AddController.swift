//
//  AddController.swift
//  Keymate
//
//  Created by Laureen Schausberger on 28.02.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import UIKit
import CoreData

class AddController: BaseTableViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    let categories: [String] = ["Login","Bankaccount","Personal","Other"]
    
    @IBOutlet weak var categoryPicker:    UIPickerView!
    @IBOutlet weak var labelCategory:     UILabel!
    @IBOutlet weak var textfieldName:     UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textviewNote:      UITextView!
    @IBOutlet weak var `switch`:          UISwitch!
    
    
    // MARK: Needed Calls
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Enter
    @IBAction func enterOnName(_ sender: UITextField) {
        sender.text = sender.text?.capitalized
        textfieldPassword.becomeFirstResponder()
    }
    
    @IBAction func enterOnPassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    // MARK: Save
    @IBAction func save(_ sender: Any) {
        
        if (self.textfieldName.text?.isEmpty)! {
            self.textfieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        if (self.textfieldPassword.text?.isEmpty)! {
            self.textfieldPassword.layer.borderColor = UIColor.red.cgColor
            return
        }
        if (self.labelCategory.text?.isEmpty)! {
            self.labelCategory.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        let cdManager: CoreDataManager = CoreDataManager.sharedInstance
        let key: Key = Key(context: cdManager.managedObjectContext)
        if self.switch.isOn {
            key.fav = true
        } else {
            key.fav = false
        }
        
        key.name =      self.textfieldName.text?.capitalized
        key.password =  self.textfieldPassword.text
        key.note =      self.textviewNote.text
        key.category =  self.labelCategory.text;
        cdManager.saveContext()
        
        self.setToDefault()
        
        tabBarController?.selectedIndex = 0
    }
    
    
    
    // MARK: Setup Elements
    private func setup() {
        self.delegate()
        self.borderForTextview()
        self.tableView.separatorStyle = .none
        self.navigationItem.title = "ADD NEW KEY"
        self.switch.addTarget(self, action: #selector(self.dismissKeyboard), for: .valueChanged)
     
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
        self.categoryPicker.isHidden = true
    }
    
    private func delegate() {
        textfieldName.delegate =     self
        textfieldName.tag =          0
        textfieldPassword.delegate = self
        textfieldPassword.tag =      1
    }
    
    private func borderForTextview() {
        textviewNote.layer.borderWidth =  0.5
        textviewNote.layer.borderColor =  UIColor.keymateLightGrey.cgColor
        textviewNote.layer.cornerRadius = 10
    }
    
    private func setToDefault() {
        
        self.textfieldName.text =       ""
        self.textfieldPassword.text  =  ""
        self.textviewNote.text =        ""
        
        self.textfieldName.resignFirstResponder()
        self.textfieldPassword.resignFirstResponder()
        self.textviewNote.resignFirstResponder()
        
        self.switch.setOn(false, animated: true)
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categories[row]
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.labelCategory.text = self.categories[row]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.selectionStyle
        
        if indexPath == IndexPath(row: 2, section: 0) {
            if categoryPicker.isHidden {
                categoryPicker.isHidden = false
            }
            else {
                categoryPicker.isHidden = true
            }
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.tableView.beginUpdates()
                
                self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
                self.tableView.endUpdates()
            })
        }
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 3 {
            return self.categoryPicker.isHidden ? 0 : 120
        } else if indexPath.section == 0 && indexPath.row == 5 {
            return 235
        } else {
            return 44
        }
    }
}


// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
