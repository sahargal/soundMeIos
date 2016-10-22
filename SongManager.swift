//
//  SongManager.swift
//  SoundMe
//
//  Created by Hercules on 10/8/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation
import MediaPlayer

public class SongManager {
    
    static let Instance = SongManager()
 
    open func getSongList(userId:Int)->[Song]
    {
        let songList = UserManger.Instance.getSongList(userId: userId)
         return songList
    }
    
    open func saveURL(url:URL)
    {
        _url = url
    }

    
    
    
    private var _url: URL!
    
    public private (set) var url: URL {
        
        get {
            
            return _url
            
        }
        
        set {
            
            _url = newValue
            
        }
        
    }
    
}
