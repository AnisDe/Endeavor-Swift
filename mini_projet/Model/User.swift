//
//  User.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//

import Foundation

struct User: Encodable {
    
    //internal init(_id: String? = nil, username: String? = nil, email: String? = nil,   password: String? = nil,isAdmin: Bool? = nil , isVerified: Bool? = nil  ) {
    internal init(_id:String? = nil ,username: String? = nil, email: String? = nil ,password: String? = nil, isAdmin: Bool? = nil , isVerified: Bool? = nil ) {
        self._id = _id
        self.username = username
        self.email = email
        self.password = password
        self.isAdmin = isAdmin
        self.isVerified = isVerified
    }
    
    var _id : String?
    var username : String?
    var email : String?
    var password : String?
    var isAdmin : Bool?
    var isVerified : Bool?
}
