//
//  ProfileView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation
import UIKit

class ProfileView: UIViewController{
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nameValue  = UserDefaults.value(forKey: "username") as? String
         name.text = nameValue
    }
    
    
    

    
    
}
