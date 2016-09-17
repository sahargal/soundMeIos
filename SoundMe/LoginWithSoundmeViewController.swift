//
//  LoginWithSoundmeViewController.swift
//  SoundMe
//
//  Created by dror gal on 06/08/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

class LoginWithSoundmeViewController: UIViewController {
    @IBOutlet weak var emailTextFeild: UITextField!

    @IBOutlet weak var iAmReadyButton: UIImageView!
    @IBOutlet weak var passwordTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginWithSoundmeViewController.didMoveToNext))
        tapGesture.numberOfTapsRequired = 1
        self.iAmReadyButton.addGestureRecognizer(tapGesture)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        
    }
    
    func didMoveToNext(){

        self.performSegue(withIdentifier: "moveToMain", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
