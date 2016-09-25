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



    open func logInUser(_ email:String, password:String,callback:@escaping (_ success:Bool,_ result:String)->()){
        API.login(email, password: password) { (success, result) -> () in
            if (!success) {   //(x!) error!!
            callback(true, "sucess")
            }
                
            else {
            callback(false, "error")
            }
        }
        
        
    }
    
    open func SignInWithSoundMe(_ userName:String,UserEmail:String,userPassword:String,callback:(_ sucssesToSighnIN:Bool)->()){

    }

    open func SignInFaceback(UserEmail:String,userName:String,callback:@escaping (_ sucssesToSighnIN:Bool)->()){
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
    open func getUserMe(_ userId:Int,callback:(_ succcess:Bool,_ result:String)->()){
            //cheak if id  exist
            
            callback(true,"result") //type esponseServer(jason)
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    public func getLocation(locationUser:Location,callback:(sucsses:Bool,)->()){
        
 //   }
 //   public func getFreindsLocation(locationOfMyFreindsList:[Location],callback:(sucsses:Bool,listLocationOfmyFreinds:[])){
//    }
    
    //פןנקציות שמקבלות מידע מהapi
   
    open func getDetailMyFriends() {
    }
    open func logout(){
    }
    
}

//callback - מה הפוקנציה מחזירה(תשובה)
// example for callback
// public func cheackNewUserRegiteration(email:String,name:String,password:String,callback:(sucsses:Bool,result:String)->())
// {

//    callback(sucsses: true, result: "sucess to sign in")
//    }
// }




















