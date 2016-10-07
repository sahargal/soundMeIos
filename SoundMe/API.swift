//
//  API.swift
//  SoundMe
//
//  Created by dror gal on 3/5/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation
import Parse

public typealias MainThreadCallback = ()->()

open class API{
    struct APIKey {
        static let UserName = "name"
        static let Password = "password"
        static let className = "newUser"
    }
    


    /// all api funcs back with json object (nsdic)
    
    static func login(_ email:String,password:String,callback:@escaping (_ success:Bool,_ result:String)->()){
        
        do{
            let path = Bundle.main.path(forResource: "sessionkey", ofType: "json")
            let jsonData = NSData(contentsOfFile: path!)
            let response = try JSONSerialization.jsonObject(with: jsonData as! Data, options: .mutableLeaves) as! NSDictionary
            let sessionKey:String = response["sessionkey"] as! String
            callback(true, sessionKey)
        }catch{
            print(error)
            callback(false, "")
        }

    }
    
    
    static func getUsers(sessionKey:String,callback:@escaping (_ success:Bool,_ result:NSArray)->()){
        
        do{
            let path = Bundle.main.path(forResource: "users", ofType: "json")
            let jsonData = NSData(contentsOfFile: path!)
            let response = try JSONSerialization.jsonObject(with: jsonData as! Data, options: .mutableLeaves) as! NSDictionary
            
            let users:NSArray = response["users"] as! NSArray
            callback(true, users)
        }catch{
            print(error)
            callback(false, [])
        }
       
    }
    
    static func getLoginUser(sessionKey:String,callback:@escaping (_ success:Bool,_ result:NSArray)->()){
        
        do{
            let path = Bundle.main.path(forResource: "loginUser", ofType: "json")
            let jsonData = NSData(contentsOfFile: path!)
            let response = try JSONSerialization.jsonObject(with: jsonData as! Data, options: .mutableLeaves) as! NSDictionary
            
            let users:NSArray = response["loginUser"] as! NSArray
            callback(true, users)
        }catch{
            print(error)
            callback(false, [])
        }
        
    }
    
    static func signIn(email:String,password:String,name:String,callback: @escaping (_ success:Bool,_ result:String)->()) {
        let url = "http://sahargever"
        
        WebServices.Instance.postSyncJSON(params: ["Email":email,"Password":password,"Name":name], url: url) {(success,result)->() in
            if success {
                login(email, password: password, callback: {(success,result)->() in
                    if success{
                        callback(true,result)
                    }else
                    {
                       callback(false,"")
                    }
                })
            }
            else
            {
                callback(false, "")
            }
        }
    }
    
    ////change value radius 
    
    static func changeRadiusValue(radius: String,sessionKey:String,callback:@escaping (_ success:Bool,_ result:String)->())
    {
        let url = "http://changeRadius"
      //  let radiusString = String(radius)
        WebServices.Instance.postSyncJSON(params: ["sessionKey":sessionKey,"radius":radius], url: url)
        {(success,result)->() in
            if success
            {
                //result is type serever response
                callback(true,"result")
            }
            else
            {
                callback(false,"")
            }
            
            
        }
        
    }
    
    
    static func LogOut(sessionKey:String,callback: @escaping (_ success:Bool,_ result:String)->())
    {
    let url = "Httop://logOut"
        WebServices.Instance.postSyncJSON(params: ["SessionKey":sessionKey], url: url)
        {(success,result)->() in
            if success
            {
                callback(true,"result")
            }
            else
            {
                callback(false,"")
            }
        }
    }
    
        
    
    
    
    
    
    
}
