//
//  Location.swift
//  SoundMe
//
//  Created by Hercules on 9/13/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation
import GoogleMaps

open class Location{
    
    init(json:NSDictionary) {
        _latitude = Double(json["latitude"] as! String)!
        _longitude = Double(json["longitude"] as! String)!
    }
    
    private var _latitude: CLLocationDegrees
    
    private (set) var latitude: CLLocationDegrees {
        get {
            return _latitude
        }
        set {
            _latitude = newValue
        }
    }
    
    private var _longitude: CLLocationDegrees
    
    private (set) var longitude: CLLocationDegrees {
        get {
            return _longitude
        }
        set {
            _longitude = newValue
        }
    }
}
