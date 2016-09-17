//
//  MeViewController.swift
//  SoundMe
//
//  Created by dror gal on 09/09/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        
    }
    
    

}
