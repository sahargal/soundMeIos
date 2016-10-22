//
//  songTableViewTableViewCell.swift
//  SoundMe
//
//  Created by dror gal on 14/10/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class songTableViewTableViewCell: UITableViewCell {
    
    var isInstall:Bool = false
    var player:AVPlayer!
    var url:String = ""
    
    
    @IBOutlet weak var firstNameLabel: UILabel!

  
    @IBOutlet weak var artist: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        player = AVPlayer()

        
        
    }
    @IBAction func playClick(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            player.pause()
        }else{
            sender.isSelected = true
            if isInstall{
                player.play()
            }else{
                playSound(urlTo: url)
            }
            
        }
    }
    
    func setUrl(url:String){
        self.url = url
    }
    
    func playSound(urlTo:String) {
        
        let playerItem = AVPlayerItem( url:NSURL( string:urlTo ) as! URL )
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.play()
        isInstall = true
    }

}
