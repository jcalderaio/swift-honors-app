//
//  Helper.swift
//  SwiftHonorsApp
//
//  Created by John Calderaio on 10/11/16.
//  Copyright © 2016 John Calderaio. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static let helper = Helper()
    
    func loginDidTapped() {
        
        //  We switch view by setting navigation controller as the new root view controller
        
        //  Create a main storyboard instance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //  From main storyboard instantiate a navigation controller
        let tabBarVC = storyboard.instantiateViewControllerWithIdentifier("TabBarVC") as! UITabBarController
        
        //  Get the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //  Set navigation controller as root view controller
        appDelegate.window?.rootViewController = tabBarVC
        
    }
    
}