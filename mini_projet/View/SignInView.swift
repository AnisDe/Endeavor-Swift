//
//  SignInView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import AuthenticationServices
import Foundation
import UIKit
import Alamofire

class SignInView: UIViewController {
    
    struct SignInData {
         var username: String?,
         password:String?

    }
    var data : SignInData?

    // iboutlets
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    private let signInWithApple = ASAuthorizationAppleIDButton()
    
    // protocols
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInWithApple)
        
    }
    
    // methods
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInWithApple.frame = CGRect(x: 73, y: 526, width: 250, height: 50)
        signInWithApple.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    // actions
    
    @objc func didTapSignIn () {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName , .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.performRequests()
    }
    
    @IBAction func Login(_ sender: Any) {
        
        data = SignInData(
            username: Username.text,
            password: Password.text
        
        )
        
        
            UserViewModel().login(username: (data?.username)! , password: (data?.password)!, completed: { (success, response) in
            if (success) {
               
                let user = response as! User
                                
                                if (user.isVerified!) {
                                    self.performSegue(withIdentifier: "profileSegue", sender: nil)
                                }
                                else {
                                    let action = UIAlertAction(title: "Proceed", style: .default) { promptAction in
                                        
                                    }
                                    self.present(Alert.makeActionAlert(titre: "Notice", message: "The email linked to this account is not confirmed ", action: action), animated: true)
                                }
            } else {
                self.present(Alert.makeAlert(titre: "Warning", message: "wrong password or username "), animated: true)
            }
         })
     }
 }

extension SignInView: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController , didCompleteWithError error :Error)  {
        print("failed!")
    }
    func authorizationController(controller: ASAuthorizationController , didCompleteWithAuthorization authorization:ASAuthorization)  {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let email = credentials.email
            
            UserDefaults.standard.set(firstName, forKey: "username")
            UserDefaults.standard.set(email, forKey: "email")
            let profile = self.storyboard?.instantiateViewController(withIdentifier: "profileView")
            self.present(profile!, animated: true, completion: nil)
        default:
            print("something went wrong")
        }
    }
}
extension SignInView : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor (for controller: ASAuthorizationController) -> ASPresentationAnchor{
        return view.window!
    }
}

