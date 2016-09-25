//
//  WebServices.swift
//
//
//  Created by Dev on 12/20/15.
//  Copyright © 2015 Dev. All rights reserved.
//

import Foundation

class WebServices {
    
    static let Instance = WebServices()
    
    private init() {
        
    }
    
    func postSyncJSON(params : Dictionary<String, String>, url : String, postCompleted : @escaping (_ success: Bool, _ result : ServerResponse ) -> ()) {
        let mutex : DispatchSemaphore = DispatchSemaphore(value: 0)
        let completion = postCompleted
        postAsyncJSON(params: /*params*/["":""], url: url, postCompleted: {success, result -> Void in
            completion(success, result)
            mutex.signal()
        })
        mutex.wait(timeout: .distantFuture)
    }
    
    func postAsyncJSON(params : Dictionary<String, String>, url : String, postCompleted : @escaping (_ success: Bool, _ result : ServerResponse ) -> ()) {
        //create the url with NSURL
        let nsURL = NSURL(string: url) //change the url
        
        //create the session object
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: nsURL! as URL)
        request.httpMethod = "POST" //set http method as POST
        
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err) // pass dictionary to nsdata object and set it as request body
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setBodyContent(contentMap: params)
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            do {
                var responseData = data
                if responseData == nil {
                    responseData = NSData() as Data
                }
                let serverResponse = ServerResponse(data: responseData!)
                postCompleted(true, serverResponse)
                
                if(error != nil) {
                    print(error!.localizedDescription)
                    let jsonStr = NSString(data: responseData!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: '\(jsonStr)'")
                } else {
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = serverResponse.getAsDictionary() as NSDictionary! {
                        // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                        _ = parseJSON["success"] as? Int
                        //println("Succes: \(success)")
                    } else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        // println("Error could not parse JSON: \(jsonStr)")
                    }
                }
            } catch {
                print("PostAsyncJson error")
                
                
                
            }
            
        })
        
        task.resume()
    }
    
}
extension NSMutableURLRequest {
    func setBodyContent(contentMap: Dictionary<String, String>) {
        var firstOneAdded = false
        var contentBodyAsString = String()
        let contentKeys:Array<String> = Array(contentMap.keys)
        for contentKey in contentKeys {
            if(!firstOneAdded) {
                
                contentBodyAsString = contentBodyAsString + contentKey + "=" + contentMap[contentKey]!
                firstOneAdded = true
            }
            else {
                contentBodyAsString = contentBodyAsString + "&" + contentKey + "=" + contentMap[contentKey]!
            }
        }
        contentBodyAsString = contentBodyAsString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.httpBody = contentBodyAsString.data(using: String.Encoding.utf8)
    }
}
