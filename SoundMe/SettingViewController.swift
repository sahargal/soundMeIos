//
//  SettingViewController.swift
//  SoundMe
//
//  Created by Hercules on 9/23/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation


class SettingViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var changeRadiusLabel: UILabel!
    @IBOutlet weak var logOutLabel: UILabel!
    @IBOutlet weak var optionRadiusPicker: UIPickerView!
    let radiusArray = ["1 Km","2 Km","3 Km","4 Km","5 Km","6 Km","7 Km","8 Km","9 Km","10 Km"]
    
    override func viewDidLoad() {
        optionRadiusPicker.isHidden = true
        optionRadiusPicker.delegate = self
        optionRadiusPicker.dataSource = self
        optionRadiusPicker.tag = 1
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        setDeafultRadius()
       
        let tapGestureEditRadius = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.editRadius))
        tapGestureEditRadius.numberOfTapsRequired = 1
        self.changeRadiusLabel.addGestureRecognizer(tapGestureEditRadius)
       
        let tapGestureLogOut = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.actionLogOut))
        tapGestureLogOut.numberOfTapsRequired = 1
        self.logOutLabel.addGestureRecognizer(tapGestureLogOut)
        
    }
    
    

    
    private func setDeafultRadius(){
        let deafultRadius = 2
        changeRadiusLabel.text = String(deafultRadius)
        changeRadiusAcion()
    }
    
      func editRadius(){
        optionRadiusPicker.isHidden = false
    }
    
    
    @objc private func changeRadiusAcion(){
        let radius = changeRadiusLabel.text!
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
    
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return radiusArray.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String?  {
       return radiusArray[row]
    }
    
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeRadiusLabel.text = String(row+1)
        optionRadiusPicker.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleRadius = radiusArray[row]
        let attributedString = NSAttributedString(string: titleRadius, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    
    
    
    
    
   @objc private func actionLogOut() {
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
            if (changeRadiusLabel.text?.isEmpty)! {
               changeRadiusLabel.text = "2"
                changeRadiusAcion()
            }
            else
            {
            changeRadiusAcion()
            }
            return true

       }
    
    
 
}
