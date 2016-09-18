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
    
    
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var loginWithSoundMe: UIImageView!
    @IBOutlet weak var loginWithFacebook: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorActivity.isHidden = true
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
        indicatorActivity.isHidden = false
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
                let UserDataFaildMsg = "The user are not exited, or maybe connection failed"
                let titleMsgPath = "connection faild"
                self.msgError(titleMsg: titleMsgPath,detailMsg: UserDataFaildMsg)
                print("Error: \(error)")
            }
            else
            {
                let newResult = result as! NSDictionary
                let userName : String = newResult.value(forKey: "name") as! String
                let userEmail : String = newResult.value(forKey: "email") as! String
                print("User Detail:",userName,userEmail)
                UserManger.Instance.SignInFaceback(UserEmail: userEmail, userName:userName, callback: { (Bool) in
                    ViewControllerUtils.doOnMain {
                        if Bool{
                            self.indicatorActivity.isHidden = true
                            
                            //self.performSegue(withIdentifier: "AlreadyLoginIn", sender: self)
                        }else{
                            self.indicatorActivity.isHidden = true
                            let msgUserManagerError = "connection with the server failed"
                            let titleUsermanagerError = "Error"
                            self.msgError(titleMsg: titleUsermanagerError, detailMsg: msgUserManagerError)
                        }
                    }
                })
            }
        })
    }
  
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    private func msgError(titleMsg:String? ,detailMsg: String){
        
        let msgAlert = UIAlertController(title: titleMsg, message: detailMsg, preferredStyle: UIAlertControllerStyle.alert)
        msgAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(msgAlert, animated: true, completion: nil)
    }
    
    
    
    
}

