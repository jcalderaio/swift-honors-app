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
        
        profileViewName.text = userName
        
        profileViewEmail.text = userEmail
        
        profileViewImage.image = userImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
