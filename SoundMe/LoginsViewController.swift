//
//  LoginsViewController.swift
//  SoundMe
//
//  Created by dror gal on 05/08/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit
import MediaPlayer
import FBSDKCoreKit
import FBSDKLoginKit

class LoginsViewController: UIViewController,FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginWithSoundMe: UIImageView!
    @IBOutlet weak var loginWithFacebook: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginWithFacebook.delegate = self
        loginWithFacebook.readPermissions = ["public_profile", "email", "user_friends"]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginsViewController.actionLoginSoundMe))
        tapGesture.numberOfTapsRequired = 1
        self.loginWithSoundMe.addGestureRecognizer(tapGesture)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundLogin")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionLoginSoundMe(){
        self.performSegue(withIdentifier: "goLoginSoundMe", sender: self)

    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //show
        returnUserData()
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //Todo
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                //Login error msg alert
                print("Error: \(error)")
                //hide
            }
            else
            {
                let newResult = result as! NSDictionary
                let userName : String = newResult.value(forKey: "name") as! String
                let userEmail : String = newResult.value(forKey: "email") as! String
                print("User Detail:",userName,userEmail)
                UserManger.Instance.SignInFaceback(userName, UserEmail: userEmail, callback: { (Bool) in
                    ViewControllerUtils.doOnMain {
                        if Bool{
                            //hide
                            
                            //self.performSegue(withIdentifier: "AlreadyLoginIn", sender: self)
                        }else{
                            //hide
                            
                            //msg error stay on page
                        }
                    }
                })
            }
        })
    }
  
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    
    
}

