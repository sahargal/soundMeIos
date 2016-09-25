//
//  User.swift
//  SoundMe
//
//  Created by Hercules on 9/12/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation
import UIKit


open class User {
    
    // userId name birthday need to be let but the function createnewUser wont work
 
    var userId: Int!
    var userName: String!
    var userPassword: String!
    var userIcon: UIImage!
    var userBirthDayDate: String!
  //var userLocation: Location!
 // var userSongList: [SongList]!
    private var _userRadius: String!
    var userSongList = ["my name","balbeli oto","al taasi lo heshbon"]
    var userArray = [User]()
    
    init(userId:Int,userName:String,userPassword:String,userIcon:UIImage ,userBirthDayDate:String,userRadius:String)
    {
        
        self.userId = userId
        self.userName = userName
        self.userPassword = userPassword
        self.userIcon = userIcon
        self.userBirthDayDate = userBirthDayDate
        self.userRadius = userRadius
        userArray.append(User.init(userId: self.userId, userName: self.userName, userPassword: self.userPassword, userIcon: self.userIcon, userBirthDayDate: self.userBirthDayDate,userRadius: self.userRadius))
        }
        
        
    
    
     init(){
        userName = ""
        userPassword = ""
        userIcon = UIImage(named: "poop")
        userBirthDayDate = ""
        userRadius = "2"
           }
    
    private (set) var userRadius: String {
        get {
            return _userRadius
        }
        set {
            _userRadius = newValue
        }
    }
    
    
    
 //   public init(Jason){}

    
    
}

    
    

