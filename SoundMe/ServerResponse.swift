//
//  serverResponse.swift
//  dror gal
//
//  Created by dror gal on 1/11/16.
//  Copyright © 2016 Dev. All rights reserved.
//

import Foundation

class ServerResponse{
    var serverResult:Data
    var valid:Bool = false
    var responseDictionary:NSDictionary?
    init(data:Data){
        self.serverResult = data
        let strData = NSString(data: serverResult, encoding: String.Encoding.utf8.rawValue)
        print(strData)
        if strData != ""{
            do{
                let response = try JSONSerialization.jsonObject(with: serverResult, options: .mutableLeaves) as! NSDictionary
                let value = response.value(forKey: "status") as? NSString
                if value != nil {
                    if value!.range(of: "error", options: NSString.CompareOptions.caseInsensitive).length == 0 {
                        valid = true
                        responseDictionary = response
                    }
                } else{
                    valid = true
                    responseDictionary = response
                }
             
            } catch {
                
            }
        }
        
        
    }
    
    func getAsDictionary()->NSDictionary?{
        
        return responseDictionary
    }
    func isValid()->Bool{
        return valid
    }
}
