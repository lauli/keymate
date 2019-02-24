//
//  BaseTabBarController.swift
//  Keymate
//
//  Created by Laureen Schausberger on 27.01.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTabBarBorder()
        self.setupAppearance()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAppearance() {
        UITabBar.appearance().barTintColor = UIColor.keymateWhite
        
        UITabBar.appearance().tintColor = UIColor.keymateOrange
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.keymateGrey],
            for: UIControlState.normal
        )
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.keymateOrange],
            for: UIControlState.selected
        )
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.keymateGrey],
            for: UIControlState.reserved
        )
        
        UIView.appearance(whenContainedInInstancesOf: [UITabBar.self]).tintColor = UIColor.keymateGrey
        UINavigationBar.appearance().barTintColor = UIColor.keymateOrange
        UITabBar.appearance().shadowImage = UIImage()
    }

    func createTabBarBorder() {
        let borderView = UIView(frame:
            CGRect(
                x: 0,
                y: 0,
                width: tabBar.frame.size.width,
                height: 0.2
            )
        )
        
        borderView.backgroundColor = UIColor.keymateTabBarBorderGrey
        borderView.tag = 2
        
        self.tabBar.addSubview(borderView)
        self.tabBar.sendSubview(toBack: borderView)
    }

}
