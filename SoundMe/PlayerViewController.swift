//
//  PlayerViewController.swift
//  SoundMe
//
//  Created by dror gal on 01/10/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerViewController: UIViewController {
    var i = 0
    var isPlayMode:Bool = false
    var mediaItems:[MPMediaItem]!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var iconSong: UIImageView!
    @IBOutlet weak var songTime: UILabel!
    @IBOutlet weak var play: UIImageView!
    @IBOutlet weak var nextSong: UIImageView!
    @IBOutlet weak var backSong: UIImageView!
    var player:MPMusicPlayerController!
    var songPlay:MPMediaItem!
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        
        let playTapGesture = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.playTap))
        playTapGesture.numberOfTapsRequired = 1
        self.play.addGestureRecognizer(playTapGesture)
        
        let nextSongTapGesture = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.nextSongTap))
        nextSongTapGesture.numberOfTapsRequired = 1
        self.nextSong.addGestureRecognizer(nextSongTapGesture)
        
        let backSongTapGesture = UITapGestureRecognizer(target: self, action: #selector(PlayerViewController.backSongTap))
        backSongTapGesture.numberOfTapsRequired = 1
        self.backSong.addGestureRecognizer(backSongTapGesture)
    
        mediaItems = MPMediaQuery.songs().items
        player = MPMusicPlayerController.systemMusicPlayer()
        songPlay = mediaItems[i]
        player.nowPlayingItem = songPlay
        songTitle.text = songPlay.title
        songArtist.text = songPlay.artist
        
        songTime.text = String(describing: songPlay.value(forProperty: MPMediaItemPropertyPlaybackDuration)!)
        print(songPlay.bookmarkTime)
        print(songPlay.playbackDuration)
  
    }

    func playTap(){
        if isPlayMode{
            isPlayMode = false
            player.stop()
            play.image = UIImage(named: "iconPlay")

        }else{
            isPlayMode = true
            play.image = UIImage(named: "iconPause")
            player.play()
        }
    
           // print(song.title)
        
    }
    
    func nextSongTap(){
        player.stop()
        i+=1
        songPlay = mediaItems[i]
        isPlayMode = true
        play.image = UIImage(named: "iconPause")
        player.play()
        songTime.text = String(describing: songPlay.value(forProperty: MPMediaItemPropertyPlaybackDuration)!)

        songTitle.text = songPlay.title

    }
    
    func backSongTap(){
        player.stop()
        i-=1
        songPlay = mediaItems[i]
        isPlayMode = true
        play.image = UIImage(named: "iconPause")
        player.play()
        songTitle.text = songPlay.title
        songTime.text = String(describing: songPlay.value(forProperty: MPMediaItemPropertyPlaybackDuration)!)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
