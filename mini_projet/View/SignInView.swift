//
//  SignInView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation
import UIKit

class SignInView: UIViewController {
    
    struct SignInData {
         var username: String?,
         password:String?

    }
    var data : SignInData?

    // iboutlets
       @IBOutlet weak var UsernameTF: UITextField!
       @IBOutlet weak var passwordTF: UITextField!
    
    // protocols
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // methods
  
    
    // actions
    
    @IBAction func Login(_ sender: Any) {
        
        data = SignInData(
            username: UsernameTF.text,
            password: passwordTF.text
        
        )
        
        let userDefaults = UserDefaults()
        
        userDefaults.set(UsernameTF.text, forKey: "username")
        
        UserViewModel().login(username: (data?.username)! , password: (data?.password)!) { success in
            if (success) {
                let action = UIAlertAction(title: "Proceed", style: .default) { promptAction in
                    
                }
                self.present(Alert.makeSingleActionAlert(titre: "Login", message: "Logged In", action: action), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Warning", message: "wrong password or username "), animated: true)
            }
        }

    }
}
