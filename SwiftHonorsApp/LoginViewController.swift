//
//  ViewController.swift
//  SwiftHonorsApp
//
//  Created by John Calderaio on 9/26/16.
//  Copyright © 2016 John Calderaio. All rights reserved.
//

import UIKit

var userName:String = ""
var userEmail:String = ""
var userImage:UIImage? = nil
var loggedIn:Bool = false


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
     //  This adds the Login button to the View Controller
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If "loggedIn" has a value from a previos run, set it here
        if defaults.objectForKey("loggedIn") != nil {
            loggedIn = defaults.objectForKey("loggedIn") as! Bool
        }
        
        //  If "loggedIn" true, then go to first page, else do nothing
        if defaults.objectForKey("loggedIn") != nil && defaults.objectForKey("loggedIn") as! Bool
        {
            //Helper.helper.loginDidTapped()  FOR NOW, LOGOUT BUTTON WONT SHOW UP SO WE DONT WANT THIS TO WORK
        }
        
        // Adding these two things
        navigationController?.navigationBar.translucent = false
        self.extendedLayoutIncludesOpaqueBars = true
        // prevent extra padding and wierd navi colors
        
        navigationItem.title = "Facebook Login"
        
        //Set background color to light blue
        self.view.backgroundColor = UIColorFromHex(0x4099FF, alpha: 1);
        
        //  Add Login button as a subview
        view.addSubview(loginButton)
        
        //  Centers login button
        loginButton.center = view.center
        
        loginButton.delegate = self
        
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
            print("Token: \(token)")
        }
        
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError)
                return
            }
            
            userEmail = (user["email"] as? String)!
            let firstName = user["first_name"] as? String
            let lastName = user["last_name"] as? String
            
            userName = "\(firstName!) \(lastName!)"
            
            var pictureUrl = ""
            
            if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                pictureUrl = url
            }
            
            let url = NSURL(string: pictureUrl)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error)
                    return
                }
                
                let image = UIImage(data: data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    userImage = image!
                })
                
            }).resume()
            
        })
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            
            print("completed login")
            fetchProfile()
            
            defaults.setObject(true, forKey: "loggedIn")
            
            Helper.helper.loginDidTapped()
            
        }
        else {
            print(error!.localizedDescription)
            return
        }

    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        defaults.setObject(false, forKey: "loggedIn")
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

