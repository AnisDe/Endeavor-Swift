//
//  ProfileView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation
import UIKit

class ProfileView: UIViewController{
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = UserDefaults.standard.object(forKey: "username") as? String
        email.text = UserDefaults.standard.object(forKey: "email") as? String
    }
    
    
    

    
    
}
