//
//  SongHome.swift
//  SoundMe
//
//  Created by dror gal on 07/10/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation

import MediaPlayer



public class SongHome:Song {
    
    
    
    
    
    init(name:String,artist:String,time:String,icon:UIImage,file:MPMediaItem){
        
        _file = file
        
        super.init(name: name, artist: artist, time: time, icon: icon)
        
        
        
    }
    
    
    
    private var _file:MPMediaItem!
    
    
    
    public private (set) var file:MPMediaItem {
        
        get {
            
            return _file
            
        }
        
        set {
            
            _file = newValue
            
        }
        
    }
    
    
    
}
