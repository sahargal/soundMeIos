//
//  LoginWithSoundmeViewController.swift
//  SoundMe
//
//  Created by dror gal on 06/08/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

class LoginWithSoundmeViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var iAmReadyButton: UIImageView!
    @IBOutlet weak var passwordTextFeild: UITextField!
    var acount:Account!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorActivity.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginWithSoundmeViewController.didMoveToNext))
        tapGesture.numberOfTapsRequired = 1
        self.iAmReadyButton.addGestureRecognizer(tapGesture)
        emailTextFeild.delegate = self
        passwordTextFeild.delegate = self

        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextFeild {
            self.passwordTextFeild.becomeFirstResponder()
        }
        if textField == passwordTextFeild {
            dismissKeyboard()
        }
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didMoveToNext(){
        indicatorActivity.startAnimating()
        indicatorActivity.isHidden = false
        
        if (emailTextFeild.text == "") || (passwordTextFeild.text == ""){
            indicatorActivity.isHidden = true
            msgErrorLogin(titleMsg: "Error", detailMsg: "One of the labels is empty")
        }else{
            SessionManager.Instance.loginUser(emailTextFeild.text!, password: passwordTextFeild.text!, callback:{(success)-> () in
                ViewControllerUtils.doOnMain {
                    if success{
                        self.acount = Account(email: self.emailTextFeild.text!, password: self.passwordTextFeild.text!)
                        self.performSegue(withIdentifier: "moveToMain", sender: self)
                    }else{
                        self.msgErrorLogin(titleMsg: "Error server", detailMsg: "user is not exit")
                        self.indicatorActivity.isHidden = true
                    }
                }
               
            })
        }
    }
  
    private func msgErrorLogin(titleMsg:String? ,detailMsg: String){
        let msgAlert = UIAlertController(title: titleMsg, message: detailMsg, preferredStyle: UIAlertControllerStyle.alert)
        msgAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(msgAlert, animated: true, completion: nil)
    }
 
}

