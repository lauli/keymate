//
//  BaseViewController.swift
//  Keymate
//
//  Created by Laureen Schausberger on 04.03.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var `switch`: UISegmentedControl!
    @IBOutlet weak var containerAll: UIView!
    @IBOutlet weak var containerFavorit: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setContainerVisibility(forAll: false, forFavorit: true)
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Custom Methods
    private func setContainerVisibility(forAll: Bool, forFavorit: Bool) {
        self.containerAll.isHidden = forAll
        self.containerFavorit.isHidden  = forFavorit
    }

    @IBAction func valueChanged(_ sender: Any) {
        setContainerVisibility(forAll: !self.containerAll.isHidden, forFavorit: !self.containerFavorit.isHidden)
    }
    
    // MARK: Setup Elements
    private func setup() {
        self.navigationItem.title = "KEYS"
        if let navController: UINavigationController = self.navigationController {
            navController.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.keymateHelveticaCondensedBold(fontSize: 20) ]
            navController.navigationBar.barStyle         = UIBarStyle.blackTranslucent
            navController.navigationBar.barTintColor     = UIColor.keymateOrange
            navController.navigationBar.isTranslucent    = false
        }
    }
}
