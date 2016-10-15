//
//  Song.swift
//  SoundMe
//
//  Created by dror gal on 07/10/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation

public class Song {
    
    
    
    
    
    public enum SongType {
        
        case Home
        
        case Out
        
    }
    
    //dror
    
    init(name:String,artist:String,time:String,icon:UIImage) {
        
        _name = name
        
        _artist = artist
        
        _time = time
        
        _icon = icon
        
        
        
    }
    
    
    
    init(json:NSDictionary) {
        
        _name = json["name"] as! String
        
        _artist = json["artist"] as! String
        
        _time = json["time"] as! String
        
        _icon = UIImage(named:"me")!//json["icon"] as! UIImage
        
    }
    
    
    
    private var _name: String
    
    public private (set) var name: String {
        
        get {
            
            return _name
            
        }
        
        set {
            
            _name = newValue
            
        }
        
    }
    
    
    
    private var _artist: String
    
    public private (set) var artist: String {
        
        get {
            
            return _artist
            
        }
        
        set {
            
            _artist = newValue
            
        }
        
    }
    
    
    
    private var _time: String
    
    public private (set) var time: String {
        
        get {
            
            return _time
            
        }
        
        set {
            
            _time = newValue
            
        }
        
    }
    
    
    
    private var _icon: UIImage
    
    public private (set) var icon: UIImage {
        
        get {
            
            return _icon
            
        }
        
        set {
            
            _icon = newValue
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
