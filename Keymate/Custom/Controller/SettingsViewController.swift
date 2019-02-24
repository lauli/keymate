//
//  SettingsViewController.swift
//  Keymate
//
//  Created by Laureen Schausberger on 05.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import UIKit

class SettingsViewController: BaseTableViewController {

    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var cellDatePicker: UITableViewCell!
    @IBOutlet weak var cellNote: UITableViewCell!
    @IBOutlet weak var cellSave: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var note: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSwitch()
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if self.switch.isOn {
            self.setFingerprint(possible: true)
        } else {
            self.setFingerprint(possible: false)
        }
        
    }
    
    @IBAction func switchNotification(_ sender: Any) {
        if self.switchNotification.isOn {
            self.setVisibility(to: true)
            UserDefaults.standard.set("shown", forKey: "switchNotification")

        } else {
            self.setVisibility(to: false)
            UserDefaults.standard.set("hidden", forKey: "switchNotification")
            NotificationAngel.deleteLocalNotification()
        }
    }
    
    @IBAction func saveNotification(_ sender: Any) {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.datePicker.date)
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let minutes = components.minute, let seconds = components.second{
            print("\(day) \(month) \(year), \(hour):\(minutes):\(seconds)")
        }
        components.second = 0
        NotificationAngel.createNewNotification(at: components)
        
        if self.doWeHavePermission() {
            UserDefaults.standard.setValue(self.note.text, forKey: "note")
        } else {
            self.askForPermission()
        }
        
    }
    
    private func setSwitch() {
        if isFingerprintAllowed() {
            self.switch.setOn(true, animated: true)
        } else {
            self.switch.setOn(false, animated: true)
        }
    }
    
    private func setFingerprint(possible: Bool){
        if possible {
            UserDefaults.standard.set("true", forKey: "fingerprint")
        } else {
            UserDefaults.standard.set("false", forKey: "fingerprint")
        }
    }
    
    private func isFingerprintAllowed() -> Bool {
        if UserDefaults.standard.value(forKey: "fingerprint") == nil {
            return true
        } else {
            let holder = UserDefaults.standard.value(forKey: "fingerprint") as? String
            if holder == "true" {
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK: Setup Elements
    private func setup() {
        self.navigationItem.title = "SETTINGS"
        self.hideKeyboardWhenTappedAround()
        if UserDefaults.standard.value(forKey: "note") != nil {
            self.note.text = UserDefaults.standard.value(forKey: "note") as! String!
        }
        
        if let x = UserDefaults.standard.value(forKey: "switchNotification") as! String! {
            if x == "hidden" {
                self.switchNotification.setOn(false, animated: true)
                self.setVisibility(to: false)
            }
        }
    }
    
    // MARK: Hide Notifications
    private func setVisibility(to visibility: Bool) {
        self.cellDatePicker.isHidden = !visibility
        self.cellNote.isHidden       = !visibility
        self.cellSave.isHidden       = !visibility
    }
    

}
