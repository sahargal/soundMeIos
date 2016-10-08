//
//  UserManger.swift
//  SoundMe
//
//  Created by dror gal on 3/5/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation


open class UserManger {

    static let Instance = UserManger()
    
    


    
    open func SignInWithSoundMe(_ userName:String,UserEmail:String,userPassword:String,callback:(_ sucssesToSighnIN:Bool)->()){

    }

    open func SignInFaceback(UserEmail:String,userName:String,callback:@escaping (_ sucsses:Bool)->()){
        let userPassword:String = userName
        API.signIn(email: UserEmail, password: userPassword,name: userName, callback:{ (success,result)-> Void in
            if (success) {
                callback(true)
            }
            else {
                callback(false)
            }
            
            
        })
        
    }
    
    open func getUsers(sessionKey:String,callback:@escaping (_ succcess:Bool)->()){
        API.getUsers(sessionKey: "") { (success, result) in
            if success{
                self._users = [User]()
                for user in result{
                    self._users.append(User(json: user as! NSDictionary))
                }
                callback(true)
            }else{
                callback(false)
            }
        }
    
    }
    
    open func getLoginUser(sessionKey:String,callback:@escaping (_ succcess:Bool)->()){
        API.getLoginUser(sessionKey: "") { (success, result) in
            if success{
                for user in result{
                    self._loginUser = User(json: user as! NSDictionary)
                }
                callback(true)
            }else{
                callback(false)
            }
        }
        
    }
    
    open func getSongList(userId:Int)->[Song] {
        for user in users {
            if user.id == userId {
                return user.songList
            }
            else {
                continue
            }
        }
        return [Song]()
    }
    
    
    
    
    
    

    
    ////changeRadius/////
    
    open func changeRadius(sessionKey:String,radius:String,callback:@escaping (_ success:Bool,_ reslut:String)->()){
        API.changeRadiusValue(radius: radius, sessionKey: sessionKey, callback:
            { (success,result)->() in
            if success
            {
                callback(true,"result")
            }
            else{
                callback(false,"")
                }
            
            
           })
    }
 ///////LOG OUT
    open func LogOut(sessionKey:String, callback:@escaping (_ success:Bool,_ result:String)->()){
        API.LogOut(sessionKey: sessionKey, callback:
            {(success,result)->() in
                if success
                {
                    callback(true,"result")
                }
                else
                {
                    callback(false,"")
                }
        
            })
    }
   
    
    
    private var _loginUser: User!
    
    private (set) var loginUser: User {
        get {
            return _loginUser
        }
        set {
            _loginUser = newValue
        }
    }
    
    
    private var _users: [User]!
    
    private (set) var users: [User] {
        get {
            return _users
        }
        set {
            _users = newValue
        }
    }
    
}





















