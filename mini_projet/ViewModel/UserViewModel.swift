//
//  UserViewModel.swift
//  mini_projet
//
//  Created by Anis Demni on 12/4/2022.
//


import SwiftyJSON
import Alamofire
import Combine

class UserViewModel {
    
   
    
    
    func getUserById(_id: String?, completed: @escaping (Bool, User?) -> Void) {
        AF.request("http://localhost:3000/user/by-id",
                   method: .post,
                   parameters: ["_id" : _id!],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeUser(jsonItem: jsonData["user"])
                        print("Found user --------------------")
                        print(user)
                        print("-------------------------------")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func signUp(username: String, password: String, email:String , completed: @escaping (Bool) -> Void ) {
        AF.request("http://localhost:3000/Register",
                   method: .post,
                   parameters: [
                    "username": username,
                    "email": email,
                    "password": password,
                   ],encoder: JSONParameterEncoder.default)
            .response{ response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func login(username: String, password: String, completed: @escaping (Bool ,Any?) -> Void ) {
        AF.request("http://localhost:3000/login",
                   method: .post,
                   parameters: ["username": username, "password": password],encoder: JSONParameterEncoder.default)
            .response { response in
                
                switch response.result {
                case .success(let data):
                    do {
                         let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        let user = (json as AnyObject).value(forKey: "user") as! Dictionary<String, AnyObject>
                        let email = (user as AnyObject).value(forKey: "email") as! String
                        let _id = (user as AnyObject).value(forKey: "_id") as! String
                        let username = (user as AnyObject).value(forKey: "username") as! String
                        let isVerified = (user as AnyObject).value(forKey: "isVerified") as! Bool
                        let isAdmin = (user as AnyObject).value(forKey: "isAdmin") as! Bool
                        
                        let logedUser = User(_id:_id,username: username, email: email , isAdmin:isAdmin , isVerified: isVerified )
                        
                        UserDefaults.standard.set(username, forKey: "username")
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(_id, forKey: "_id")

                         print(logedUser)
                        completed(true , logedUser)
                    }
                    catch{
                        completed(false , nil)
                    }
                case let .failure(error):
                    print(error)
                    completed(false , nil)
                }
            }
    }
    
    
    
    func forgotPassword(email: String,  completed: @escaping (Bool) -> Void ) {
        AF.request("http://localhost:3000/forgot",
                   method: .post,
                   parameters: ["email": email], encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response{ response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func editPassword(email: String?, newPassword: String?, completed: @escaping (Bool) -> Void ) {
        AF.request("http://localhost:3000/user/editPassword",
                   method: .post,
                   parameters: [
                    "email": email!,
                    "newPassword": newPassword!
                   ])
            .response{ response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func editProfile(username: String,  completed: @escaping (Bool ,Any?) -> Void ) {

        AF.request("http://localhost:3000/edit/\(UserDefaults.standard.object(forKey: "_id")!)",
                   method: .post,
                   parameters: ["username": username],encoder: JSONParameterEncoder.default)
            .response { response in
                
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        
                        let user = (json as AnyObject).value(forKey: "user")! as AnyObject
                        UserDefaults.standard.set(username, forKey: "username")
                        completed(true ,user )
                    }
                    catch {completed(false , nil  )}
                    
                case let .failure(error):
                    print(error)
                    completed(false, nil )
                }
            }
    }
    
    func getUserFromToken(userToken: String, completed: @escaping (Bool, User?) -> Void ) {
           print("Looking for user --------------------")
           AF.request("http://localhost:3000/user/getUserFromToken",
                      method: .post,
                      parameters: ["userToken": userToken],
                      encoding: JSONEncoding.default)
               .validate(statusCode: 200..<300)
               .validate(contentType: ["application/json"])
               .response { response in
                   switch response.result {
                   case .success:
                       let jsonData = JSON(response.data!)
                       let user = self.makeUser(jsonItem: jsonData["user"])
                           print("Found user --------------------")
                           print(user)
                           print("-------------------------------")
                       completed(true, user)
                   case let .failure(error):
                       debugPrint(error)
                       completed(false, nil)
                   }
               }
       }
    
    func makeUser(jsonItem: JSON) -> User {
        User(
            //_id: jsonItem["_id"].stringValue,
            username: jsonItem["username"].stringValue,
            email: jsonItem["email"].stringValue
            //password: jsonItem["password"].stringValue

        )
    }
}
