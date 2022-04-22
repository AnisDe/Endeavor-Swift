//
//  EditProfileView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation
import UIKit

class EditProfileView: UIViewController, SecondModalTransitionListener {
    func popoverDismissed() {
        
    }
    
    
    // variables
    
    var user : User?

    // iboutlets
        
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    // protocols
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SecondModalTransitionMediator.instance.setListener(listener: self)
        emailTF.placeholder = "test"
        
        usernameTF.placeholder = UserDefaults.standard.object(forKey: "username") as? String
        emailTF.placeholder = UserDefaults.standard.object(forKey: "email") as? String

    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    // methods
    
    
    
    
    // actions
    @IBAction func confirmChanges(_ sender: Any) {
        
        if usernameTF.text!.isEmpty  {
            self.present(Alert.makeAlert(titre: "Warning", message: "You must fill all the fields"), animated: true)
            return
        }
        
        //user?.email = emailTF.text
        user?.username = usernameTF.text
        
        
        UserViewModel().editProfile(user: user!) { success in
            if success {
                let action = UIAlertAction(title: "Proceed", style: .default) { UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Profile edited successfully", action: action), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not edit your profile"), animated: true)
            }
        }
    }
    
   
}

