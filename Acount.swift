//
//  Acount.swift
//  SoundMe
//
//  Created by Hercules on 9/20/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation

public class Account : NSObject, NSCoding {
    

    
    init(email : String, password : String) {
        _email = email
        _password = password
        super.init()
    }
    
    private var _email: String
    private var _password: String
    
    private (set) var email: String {
        get {
            return _email
        }
        set {
            _email = newValue
        }
    }
    
    private (set) var password: String {
        get {
            return _password
        }
        set {
            _password = newValue
        }
    }
    
    struct PropertyKey {
        static let emailKey = "email"
        static let passwordKey = "password"
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(_email, forKey: PropertyKey.emailKey)
        aCoder.encode(_password, forKey: PropertyKey.passwordKey)
    }
    
    
    required convenience public init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObject(forKey: PropertyKey.emailKey) as? String ?? ""
        let password = aDecoder.decodeObject(forKey: PropertyKey.passwordKey) as? String ?? ""
        self.init(email: email, password: password)
    }
}


