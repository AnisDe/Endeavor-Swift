//
//  VerifAccountView.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//


import Foundation
import UIKit

class VerifAccountView: UIViewController {
    
    // variables
    var user : User?
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
        
        checkUser()
    }
    
    func checkUser(){
        
        
         
            self.performSegue(withIdentifier: "firstSegue", sender: nil)
        
    }
}

