//
//  SettingViewController.swift
//  SoundMe
//
//  Created by Hercules on 9/23/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation


class SettingViewController: UIViewController,UITextFieldDelegate {


 
    @IBOutlet weak var logOutLabel: UILabel!
    @IBOutlet weak var changeRadiusTextField: UITextField!
    
    
  
    
    override func viewDidLoad() {
        changeRadiusTextField.delegate = self
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        setDeafultRadius()
        if changeRadiusTextField.text != " " {
            changeRadiusTextField.addTarget(self, action: #selector(SettingViewController.changeRadiusAcion), for: UIControlEvents.editingChanged)
        }
        

        
        let tapGestureLogOut = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.actionLogOut))
        tapGestureLogOut.numberOfTapsRequired = 1
        self.logOutLabel.addGestureRecognizer(tapGestureLogOut)
        
    
    }
    
    

    
    private func setDeafultRadius(){
        
        let deafultRadius = 2
        changeRadiusTextField.text = String(deafultRadius)
        changeRadiusAcion()
    }
    
    
    func changeRadiusAcion(){
        let radius = changeRadiusTextField.text!
        let sessionKey = "101"
            UserManger.Instance.changeRadius(sessionKey: sessionKey, radius: radius, callback:{(success,result)->() in
                if success
                {
                    print("========working======")
                }
                else
                {
                    
                    self.msgError(titleMsg: "Error", detailMsg: "There is problem with server")

                }
            })
        
        
        
    }
    
    func actionLogOut() {
        let sessionKey = "102"
        print("success")
        let msgAlert = UIAlertController(title: "Are you sure you want to log out?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        msgAlert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil))
        msgAlert.addAction(UIAlertAction(title:"yes",style:UIAlertActionStyle.default,handler:
            {(action:UIAlertAction) in
            UserManger.Instance.LogOut(sessionKey: sessionKey, callback:
                        {(success,result)->() in
                            if success
                            {
                                self.performSegue(withIdentifier: "logOutSegue", sender: self)
                            }
                            else
                            {
                                self.msgError(titleMsg: "Ops error", detailMsg: "connection with the server failed")
                            }
                        })
            })
        )
        self.present(msgAlert, animated: true, completion: nil)
        
        
    
    }
    
    
    private func msgError(titleMsg:String? ,detailMsg: String) {
        
        let msgAlert = UIAlertController(title: titleMsg, message: detailMsg, preferredStyle: UIAlertControllerStyle.alert)
        msgAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(msgAlert, animated: true, completion: nil)
    }
    
    private func msgLogOut(){
        
        let msgAlert = UIAlertController(title: "Are you sure you want to log out?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        msgAlert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil))
        msgAlert.addAction(UIAlertAction(title:"yes",style:UIAlertActionStyle.default,handler:{(action:UIAlertAction) in self.performSegue(withIdentifier: "logOutSegue", sender: self)}))
        self.present(msgAlert, animated: true, completion: nil)
    }
    
//        func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
//    
//        }
//    
//        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
//            return false
//        }
//    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {   //delegate method
            textField.resignFirstResponder()
            if (changeRadiusTextField.text?.isEmpty)! {
               changeRadiusTextField.text = "2"
                changeRadiusAcion()
            }
            else
            {
            changeRadiusAcion()
            }
            return true

       }
    
    
 
}
