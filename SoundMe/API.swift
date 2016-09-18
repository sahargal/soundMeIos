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
        let url = "http://sahargever"
        
        WebServices.Instance.postSyncJSON(params: ["Email":email,"Password":password], url: url) { (success, result) -> () in
            let sessionKey = result.getAsDictionary()!["sessionKey"] as! String
            if sessionKey == ""{
                callback(true, sessionKey)
            }else{
                callback(false, "")
            }
        }
        
    }
    
    
    static func signIn(email:String,password:String,name:String,callback: @escaping (_ success:Bool,_ result:String)->()) {
        let url = "http://sahargever"
        
        WebServices.Instance.postSyncJSON(params: ["Email":email,"Password":password,"Name":name], url: url) {(success,result)->() in
            if success {
                login(email, password: password, callback: {(success,result)->() in
                    if success{
                        callback(true,result)
                    }else{
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
    
    
    
    
    
    
}
