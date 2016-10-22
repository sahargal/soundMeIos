//
//  ListSongForUserViewController.swift
//  SoundMe
//
//  Created by dror gal on 10/09/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class ListSongForUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate {
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    var user:User!
    @IBOutlet weak var age: UILabel!
    private let reuseIdentifier = "SongCell"
    var songList:[SongOut] = [SongOut]()
    var nowPlaySong:SongOut!
    @IBOutlet weak var nowPlayArtist: UILabel!
    @IBOutlet weak var nowPlaySongName: UILabel!
   // var player:MPMusicPlayerController!
    var player:AVPlayer!
    var isInstall:Bool = false
    var urlIndex:String = ""
    var isEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: background!)
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#49EBA5")
        let image = UIImage(named: "smallogo")!
        let imageView = UIImageView(image: image)
        userName.text = user.name
        let fullName = user.bday
        let fullNameArr = fullName.characters.split{$0 == "."}.map(String.init)
        let year = Int(fullNameArr[2])
        age.text = findAge(year: year!)
        tableView.register(UINib(nibName: "songCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.navigationItem.titleView = imageView
        getSongList()
        nowPlayArtist.text = nowPlaySong.artist
        nowPlaySongName.text = nowPlaySong.name
        self.pic.image = user.icon
        self.pic.layer.cornerRadius = self.pic.frame.size.width / 2;
        self.pic.clipsToBounds = true;
        self.pic.layer.borderWidth = 3.0
        self.pic.layer.borderColor = UIColor.white.cgColor
        player = AVPlayer()
        self.automaticallyAdjustsScrollViewInsets = false

       // player = MPMusicPlayerController.systemMusicPlayer()
    }

    @IBAction func playButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            player.pause()
        }else{
            sender.isSelected = true
            if isInstall{
                player.play()
            }else{
                playSound(urlTo: nowPlaySong.file)
            }

        }
    }
    func downloadFileFromURL(url:NSURL){
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: { (URL, response, error) -> Void in
           // self.play(url: URL!)


        })
        
        downloadTask.resume()
        
    }
    
    func playSound(urlTo:String) {
        
        let playerItem = AVPlayerItem( url:NSURL( string:urlTo ) as! URL )
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.play()
        isInstall = true
    }
    
//    func play(url:URL) {
//        print("playing \(url)")
//        
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            guard let player = player else { return }
//         
//            player.prepareToPlay()
//            player.play()
//        } catch let error as Error {
//            print(error.localizedDescription)
//        }
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.songList.count-1
    }
    
    func getSongList(){
        for (index,song) in user.songList.enumerated(){
            if index == 0{
                nowPlaySong = song
            }else{
                songList.append(song)
            }
        }
    }
    
    func findAge(year:Int)->String{
        let age = 2016 - year
        return String(age)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! songTableViewTableViewCell
        cell.backgroundColor = UIColor.clear

        cell.firstNameLabel.text = songList[indexPath.row].name
        cell.artist.text = songList[indexPath.row].artist
        cell.setUrl(url:songList[indexPath.row].file)
//        cell.playButtonSong.addTarget(self, action: #selector(ListSongForUserViewController.setPlay), for: UIControlEvents.touchUpInside)
//        isEdit = cell.playButtonSong.isSelected
//        urlIndex = songList[indexPath.row].file
        return cell
    }
    
    
    func setPlay(){
        if isEdit{
            player.pause()
        }else{
            playSound(urlTo: nowPlaySong.file)
        }
    }
  
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
