//
//  ProfileViewController.swift
//  SwiftHonorsApp
//
//  Created by John Calderaio on 10/11/16.
//  Copyright © 2016 John Calderaio. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileViewName: UILabel!
    
    
    @IBOutlet weak var profileViewEmail: UILabel!
    
    
    @IBOutlet weak var profileViewImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set background color to light blue
        self.view.backgroundColor = UIColorFromHex(0x4099FF, alpha: 1);
        
        profileViewName.text = userName
        
        profileViewEmail.text = userEmail
        
        profileViewImage.image = userImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

}
