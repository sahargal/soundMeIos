//
//  SongOut.swift
//  SoundMe
//
//  Created by dror gal on 07/10/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation

public class SoungOut:Song{
    
    
    
    
    
    init(name:String,artist:String,time:String,icon:UIImage,file:String){
        
        _file = file
        
        super.init(name: name, artist: artist, time: time, icon: icon)
        
        
        
    }
    
    
    
    private var _file: String!
    
    public private (set) var file:String {
        
        get {
            
            return _file
            
        }
        
        set {
            
            _file = newValue
            
        }
        
    }
    
}
