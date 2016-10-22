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
    var actionSheetController: UIAlertController!
    var newRadius:String! = nil
    var radiusArray:[String] = [String]()
    
    override func viewDidLoad() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundGeneral")!.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image!)
        setDeafultRadius()
       
        let tapGestureEditRadius = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.editRadiusAlertAction))
        tapGestureEditRadius.numberOfTapsRequired = 1
        self.changeRadiusLabel.addGestureRecognizer(tapGestureEditRadius)
       
        let tapGestureLogOut = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.actionLogOut))
        tapGestureLogOut.numberOfTapsRequired = 1
        self.logOutLabel.addGestureRecognizer(tapGestureLogOut)
        
        for x in 1...200{
            radiusArray.append(String(x)+"km")
        }
        
        
    }
    
    
    
    
    private func setDeafultRadius(){
        let deafultRadius = 2
        changeRadiusLabel.text = String(deafultRadius)
        changeRadiusAcion()
    }
    
    func editRadiusAlertAction(){
        let viewControllerAlert = UIViewController()
        viewControllerAlert.preferredContentSize = CGSize(width: 250, height: 150)
        
        let editRadiusAlert = UIAlertController(title: "Choose distance", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(viewControllerAlert, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style:UIAlertActionStyle.default,handler:
            {(action:UIAlertAction)->() in
            self.changeRadiusLabel.text = self.newRadius
        }))
       editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil))
        print(viewControllerAlert.view.frame.minY,viewControllerAlert.view.frame.origin.y,viewControllerAlert.view.frame.maxY)
        let pickerViewRadius = UIPickerView(frame: CGRect(x: 0, y: editRadiusAlert.view.frame.size.height/2 - 150, width: 250, height: 300))
        pickerViewRadius.delegate = self
        pickerViewRadius.dataSource = self
        viewControllerAlert.view.addSubview(pickerViewRadius)
        self.present(editRadiusAlert, animated: true, completion: nil)
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
    
      internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         newRadius =  String(row+1)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleRadius = radiusArray[row]
        let attributedString = NSAttributedString(string: titleRadius, attributes: [NSForegroundColorAttributeName : UIColor.black])
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
