//
//  LoginViewController.swift
//  Keymate
//
//  Created by Laureen Schausberger on 27.01.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var fingerprint: UIButton!
    @IBOutlet weak var firstTime: UILabel!
    
    var context = LAContext()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor.keymateOrange.cgColor
        self.passwordfield.becomeFirstResponder()
        if isPasswordSet() {
            firstTime.isHidden = true
            if !self.isFingerprintAllowed() {
                self.fingerprint.isHidden = true
            }
        } else {
            self.fingerprint.isHidden = true
            firstTime.text = "choose a secure masterkey | press enter"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Fingerprint
    @IBAction func fingerprint(_ sender: Any) {
        
            var policy: LAPolicy?
            policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
            
            var err: NSError?
            
            guard context.canEvaluatePolicy(policy!, error: &err) else {
                //if fingerprint isnt available in users ios version
                self.fingerprint.isHidden = true
                return
            }
            
            loginProcess(policy: policy!)
        }
        
        private func loginProcess(policy: LAPolicy) {
            // Start evaluation process with a callback that is executed when the user ends the process successfully or not
            context.evaluatePolicy(policy, localizedReason: "Please press your finger on your Home Button.", reply: { (success, error) in
                DispatchQueue.main.async {
                    
                    guard success else {
                        guard let error = error else {
                            return
                        }
                        switch(error) {
                        case LAError.authenticationFailed:
                            self.showAlertWith(title: "ERROR", message: "There was a problem verifying your identity.")
                        case LAError.userCancel:
                            break
                        case LAError.userFallback:
                            break
                        case LAError.systemCancel:
                            self.showAlertWith(title: "ERROR", message: "Authentication was canceled by system.")
                        case LAError.passcodeNotSet:
                           self.showAlertWith(title: "ERROR", message: "Passcode is not set on the device.")
                        case LAError.touchIDNotAvailable:
                            self.showAlertWith(title: "ERROR", message: "Touch ID is not available on the device.")
                        case LAError.touchIDNotEnrolled:
                            self.showAlertWith(title: "ERROR", message: "Touch ID has no enrolled fingers.")
                        case LAError.touchIDLockout:
                            self.showAlertWith(title: "ERROR", message: "There were too many failed Touch ID attempts and Touch ID is now locked.")
                        case LAError.appCancel:
                            self.showAlertWith(title: "ERROR", message: "Authentication was canceled by application.")
                        case LAError.invalidContext:
                            self.showAlertWith(title: "ERROR", message: "LAContext passed to this call has been previously invalidated.")
                        default:
                            self.showAlertWith(title: "ERROR", message: "Touch ID may not be configured")
                            break
                        }
                        return
                    }
                    
                    // Everything went fine 👏
                    self.forwarding()
                }
            })
        }
    
    // MARK: Masterkey
    @IBAction func clicked(_ sender: Any) {
        passwordfield.isSecureTextEntry = true
        passwordfield.textColor         = UIColor.black
    }

    @IBAction func pressedEnter(_ sender: Any) {
        print("Enter pressed")
        //hide keyboard
        self.passwordfield.resignFirstResponder()
        
        //login
        if !isPasswordSet() {
            setPassword(password: passwordfield.text!)
            self.firstTime.text = "now write it again & press enter to login"
        }
        else {
            if !isPasswordCorrect() || passwordfield.text?.characters.count == 0 {
                passwordfield.textColor         = UIColor.keymateOrange
                passwordfield.text              = "uncorrect master password"
                passwordfield.isSecureTextEntry = false
                showAlertWith(title: "Error", message: "Masterkey was incorrect.")
            } else {
                self.forwarding()
            }
        }
    }
    
    // MARK: Masterkey-Security Check
    private func isPasswordSet() -> Bool {
        if UserDefaults.standard.value(forKey: "password") == nil {
            return false
        } else {
            return true
        }
    }
    
    private func setPassword(password: String){
        let defaults = UserDefaults.standard
        defaults.set(password, forKey: "password")
    }
        
        
    private func isPasswordCorrect() -> Bool {
        if passwordfield.text == (UserDefaults.standard.value(forKey: "password") as? String) {
            return true
        } else {
            return false
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
    
    // MARK: Alert
    private func showAlertWith(title: String, message: String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    // MARK: Forwarding
    private func forwarding() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
        self.present(navigationController, animated: true)
    }
    
}
