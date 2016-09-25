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
    var acount:Account!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var iAmReadyButton: UIImageView!
    @IBOutlet weak var passwordTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorActivity.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginWithSoundmeViewController.didMoveToNext))
        tapGesture.numberOfTapsRequired = 1
        self.iAmReadyButton.addGestureRecognizer(tapGesture)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didMoveToNext(){
        self.performSegue(withIdentifier: "moveToMain", sender: self)

        /*
        var titleMsg = ""
        var deatailMsg = ""
        indicatorActivity.startAnimating()
        indicatorActivity.isHidden = false
        if (emailTextFeild.text == "") || (passwordTextFeild.text == "")
         {
            indicatorActivity.isHidden = true
             titleMsg = "Error"
             deatailMsg = "One of the labels is empty"
             msgErrorLogin(titleMsg: titleMsg, detailMsg: deatailMsg)
         }
        else
         {
                API.login(emailTextFeild.text!, password: passwordTextFeild.text!, callback:
                {(success,result)-> () in
                if (success)
                            {
                   self.acount = Account(email: self.emailTextFeild.text!, password: self.passwordTextFeild.text!)
//                 self.performSegue(withIdentifier: "moveToMain", sender: self)
                            }
                else 
                     {
                    titleMsg = "Error server"
                    deatailMsg = "user is not exit"
                    self.msgErrorLogin(titleMsg: titleMsg, detailMsg: deatailMsg)
                
                     }
                
              })
        }
        */
    }
    
private func msgErrorLogin(titleMsg:String? ,detailMsg: String)
        {
            let msgAlert = UIAlertController(title: titleMsg, message: detailMsg, preferredStyle: UIAlertControllerStyle.alert)
            msgAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(msgAlert, animated: true, completion: nil)
        }


    
    
    
}

