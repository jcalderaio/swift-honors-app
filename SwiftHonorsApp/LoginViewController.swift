//
//  ViewController.swift
//  SwiftHonorsApp
//
//  Created by John Calderaio on 9/26/16.
//  Copyright © 2016 John Calderaio. All rights reserved.
//

import UIKit

var LoggedIn = false

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
     //  This adds the Login button to the View Controller
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set background color to light blue
        self.view.backgroundColor = UIColorFromHex(0x4099FF, alpha: 1);
        
        //  Add Login button as a subview
        view.addSubview(loginButton)
        
        //  Centers login button
        loginButton.center = view.center
        
        loginButton.delegate = self
        
        /*
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
            print("Token: \(token)")
        }
        */
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
            LoggedIn = true
        }
        else {
            LoggedIn = false
        }
        print("LoggedIn: \(LoggedIn)")
        
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            if error != nil {
                print(error)
                return
            }
            
            if let email = result["email"] as? String {
                print(email)
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                print(url)
                
            }
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            
            print("completed login")
            fetchProfile()
            print("LoggedIn: \(LoggedIn)")
            
            Helper.helper.loginDidTapped()
            
        }
        else {
            print(error!.localizedDescription)
            return
        }

    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("LoggedIn: \(LoggedIn)")
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Create a custom color function
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }


}

