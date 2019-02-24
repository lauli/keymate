//
//  UIColorExtension.swift
//  Keymate
//
//  Created by Laureen Schausberger on 27.01.17.
//  Copyright © 2017 Laureen Schausberger. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Standard-Coloring-Colored
    class var keymateOrange: UIColor {
        return UIColor(red: 240.0/255.0, green: 135.0/255.0, blue: 7.0/255.0, alpha: 1.0)
    }
    
    class var keymateSelectedOrange: UIColor {
        return UIColor(red: 112.0/255.0, green: 78.0/255.0, blue: 37.0/255.0, alpha: 1.0)
    }
    
    class var keymateLightOrange: UIColor {
        return UIColor(red: 242.0/255.0, green: 168.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    }
    
    class var keymateGrey: UIColor {
        return UIColor(red: 159.0/255.0, green: 159.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    }
    
    class var keymateWhite: UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    class var keymateRed: UIColor {
        return UIColor(red: 217.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    // MARK: - Standard-Coloring-Greys
    class var keymateLightGrey: UIColor {
        return UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
    }
    
    class var keymateLighterGrey: UIColor {
        return UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    }
    
    class var keymateDarkGrey: UIColor {
        return UIColor(red: 105.0/255.0, green: 105.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    }
    
    class var keymateTabBarBorderGrey: UIColor{
        return UIColor(red: 159.0/255.0, green: 159.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    }
    
    class var keymateTableViewGrey: UIColor {
        return UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    }
    
    class var keymateTransparent: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.0)
    }
    
    // MARK: - Control-Coloring
    class var keymateTabBarIcon: UIColor {
        return keymateLightGrey;
    }
    
    class var keymateSelectedTabBarIcon: UIColor {
        return keymateOrange;
    }
    
    class var keymateNavigationBar: UIColor {
        return keymateOrange;
    }
}
