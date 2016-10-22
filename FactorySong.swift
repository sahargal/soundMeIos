//
//  FactorySong.swift
//  SoundMe
//
//  Created by Hercules on 10/15/16.
//  Copyright © 2016 sahar vanunu. All rights reserved.
//

import Foundation
import MediaPlayer
public class FactorySong: Song {
    
   static func createSong(typeOfSong:Song.SongType,name:String,artist:String,time:String,icon:UIImage,file:MPMediaItem?,url:String?)->Song{
    switch typeOfSong{
        case.Home:
            let songHome = SongHome.init(name: name, artist: artist, time: time, icon: icon, file: file!)
            return songHome
        case.Out:
            let songOut = SongOut.init(name: name, artist: artist, time: time, icon: icon, file: url!)
            return songOut
        }
    }
}
