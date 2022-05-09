//
//  EditProfileView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation
import UIKit

class EditProfileView: UIViewController {
    
    struct SignInData {
         var username: String?
    }
    var data : SignInData?

    // iboutlets
    @IBOutlet weak var username: UITextField!
    
    
    
    // protocols
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        username.placeholder = UserDefaults.standard.object(forKey: "username") as? String
        super.viewDidLoad()
        
    }
    
    // methods
  
    
    // actions
    
    @IBAction func updateProfile(_ sender: Any) {
        
        data = SignInData(
            username: username.text
        )
        
        
            UserViewModel().editProfile(username: (data?.username)! , completed: { (success , response) in
                if (success) {
                                        if (response != nil) {
                                        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                            let profile = self.storyboard?.instantiateViewController(withIdentifier: "profileView")
                                            self.present(profile!, animated: true, completion: nil)
                                        }
                                        self.present(Alert.makeSingleActionAlert(titre: "Notice", message: "Profile Updated", action: action), animated: true)
                                    }
                                    else {
                                        self.present(Alert.makeAlert(titre: "Notice", message: "We could not update your profile"), animated: true)
                                    }
                } else {
                    let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        let profile = self.storyboard?.instantiateViewController(withIdentifier: "profileView")
                        self.present(profile!, animated: true, completion: nil)
                    }
                    self.present(Alert.makeSingleActionAlert(titre: "Warning", message: "We could not update your profile", action: action), animated: true)
                }
                
                
                
                
         })
     }
    
 }
