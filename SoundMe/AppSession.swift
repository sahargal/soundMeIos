//
//  AppSession.swift
//  SoundMe
//
//  Created by Hercules on 9/16/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation

public class AppSession : NSObject, NSCoding {
  
    
    init(sessionKey : String) {
        _sessionKey = sessionKey
        super.init()
    }
    
    private var _sessionKey: String
    public private(set) var sessionKey: String {
        get {
            return _sessionKey
        }
        set {
            _sessionKey = newValue
        }
    }
    
    struct PropertyKey {
        static let sessionKeyKey = "sessionKey"
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(_sessionKey, forKey: PropertyKey.sessionKeyKey)

    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        let sessionKey = aDecoder.decodeObject(forKey: PropertyKey.sessionKeyKey) as? String ?? ""
        self.init(sessionKey: sessionKey)
    }
}
