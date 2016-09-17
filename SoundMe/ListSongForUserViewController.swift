//
//  ListSongForUserViewController.swift
//  SoundMe
//
//  Created by dror gal on 10/09/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

class ListSongForUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#49EBA5")
        let image = UIImage(named: "smallLogo")!
        let imageView = UIImageView(image: image)
        
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    static fileprivate func hexToUIColor(_ hex:String) -> UIColor {
//        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
//        
//        if (cString.hasPrefix("#")) {
//            cString = (cString as NSString).substring(from: 1)
//        }
//        
//        if (cString.characters.count != 6) {
//            return UIColor.gray
//        }
//        
//        let rString = (cString as NSString).substring(to: 2)
//        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
//        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
//        
//        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
//        Scanner(string: rString).scanHexInt32(&r)
//        Scanner(string: gString).scanHexInt32(&g)
//        Scanner(string: bString).scanHexInt32(&b)
//        
//        
//        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
//    }
//    

  
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
