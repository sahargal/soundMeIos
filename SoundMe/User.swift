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
    
    init(){
        _id = -1
        _name = ""
        _email = ""
        _icon = UIImage(named: "")!
        _bday = ""
        _location = Location(json: ["":""])
        _songList = [SongOut]()
    }
    
    init(id:Int,name:String,email:String,icon:UIImage,bday:String,location:Location,songList:[SongOut]){
        _id = id
        _name = name
        _email = email
        _icon = icon
        _bday = bday
        _location = location
        _songList = songList
    }
    
    init(json:NSDictionary) {
        _id = Int(json["id"] as! String)!
        _name = json["name"] as! String
        _icon = UIImage(named: json["image"] as! String)!
        _location = Location(json: json["location"] as! NSDictionary)
        _email = json["email"] as! String
        _bday = json["bday"] as! String
        let songsList = json["songList"] as! NSArray
        var songs:[SongOut] = [SongOut]()
        for song in songsList{
            let newSong = SongOut(json: song as! NSDictionary)
            songs.append(newSong)
        }
        _songList = songs  //until the factory will create
    }
   
    
    private var _id: Int

    private (set) var id: Int {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    private var _name: String
    
    private (set) var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    private var _email: String
    private (set) var email: String {
        get {
            return _email
        }
        set {
            _email = newValue
        }
    }
    
    
    private var _icon: UIImage
    private (set) var icon: UIImage {
        get {
            return _icon
        }
        set {
            _icon = newValue
        }
    }
    
    private var _bday: String
    private (set) var bday: String {
        get {
            return _bday
        }
        set {
            _bday = newValue
        }
    }
    
    private var _location: Location
    private (set) var location: Location {
        get {
            return _location
        }
        set {
            _location = newValue
        }
    }
    
    private var _songList: [SongOut]
    private (set) var songList:[SongOut] {
        get {
                return _songList
        }
        set {
                _songList = newValue
        }
    }
}

    
    

