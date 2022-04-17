//
//  RegisterView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import UIKit

class RegisterView: UIViewController {
    
    // variables
    
    // iboutlets
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    struct RegisterData {
         var username: String?,
         password:String?,
             email:String?

    }
    
    var data : RegisterData?

    
    // protocols
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // methods
    
    
    
    // actions
    @IBAction func Register(_ sender: Any) {
        
        if (Username.text!.isEmpty || email.text!.isEmpty ||  password.text!.isEmpty || confirmPassword.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "You must to fill all the fields"), animated: true)
            return
        }
        
        if (email.text?.contains("@") == false){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your email correctly"), animated: true)
        }
        
        if (password.text!.count < 8 ){
            self.present(Alert.makeAlert(titre: "Warning", message: "Password should be have at least 8 characters"), animated: true)
            return
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password.text!)){
            self.present(Alert.makeAlert(titre: "Warning", message: "Password should have at least one capital letter"), animated: true)
            return
        }
        
        if (password.text != confirmPassword.text){
            self.present(Alert.makeAlert(titre: "Warning", message: "Password and confirmation don't match"), animated: true)
            return
        }
        
        
        
        data = RegisterData(
            username: Username.text,
            password: password.text,
            email: email.text
        
        )
        
        
            
        
        UserViewModel().signUp(username: (data?.username)! ,password: (data?.password)! , email: (data?.email)!) { success in
                if (success) {
                    let action = UIAlertAction(title: "Proceed", style: .default) { promptAction in
                        
                    }
                    self.present(Alert.makeSingleActionAlert(titre: "Notice", message: "Welcome " + self.Username.text! + " ! please verify your email before login ", action: action), animated: true)
                } else {
                    self.present(Alert.makeAlert(titre: "Warning", message: "Error"), animated: true)
                }
            }

        
        
        
    }
    
}
