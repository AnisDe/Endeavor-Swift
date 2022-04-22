//
//  ForgotPasswordView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation
import UIKit

class ForgotPasswordView: UIViewController {
    
    // variables
    struct PasswordForgottenData {
        var email: String?

    }
    var data : PasswordForgottenData?
    
    // iboutlets
    @IBOutlet weak var emailTF: UITextField!
    
    // protocols
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // methods
  
    
    // actions
    @IBAction func sendAction(_ sender: Any) {
        
        if (emailTF.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Please type your email"), animated: true)
            return
        }
        
        
        data = PasswordForgottenData(
            email: emailTF.text
        
        )
        UserViewModel().forgotPassword(email: (data?.email)!) { success in
            if (success) {
                let action = UIAlertAction(title: "Proceed", style: .default) { promptAction in
                    
                }
                self.present(Alert.makeSingleActionAlert(titre: "Notice", message: "The password reset email has been sent to " + self.emailTF.text! + ", please open the link to reset your password.", action: action), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Warning", message: "We could not find an account linked to this email"), animated: true)
            }
            self.performSegue(withIdentifier: "loginFogetSegue", sender: nil)
        }
    }
    
}
