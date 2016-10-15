//
//  ListSongForUserViewController.swift
//  SoundMe
//
//  Created by dror gal on 10/09/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

class ListSongForUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    var user:User!
    @IBOutlet weak var age: UILabel!
    private let reuseIdentifier = "SongCell"

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.songList.count
    }
    
    func findAge(year:Int)->String{
        let age = 2016 - year
        return String(age)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! songTableViewTableViewCell
        cell.firstNameLabel.text = user.songList[indexPath.row].name
        cell.artist.text = user.songList[indexPath.row].artist
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
