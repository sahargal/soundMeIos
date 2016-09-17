//
//  ViewControllerUtils.swift
//  SoundMe
//
//  Created by Hercules on 9/16/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation
import UIKit

public class ViewControllerUtils {
    
    public static func doOnMain(callback :@escaping MainThreadCallback) {
        
        DispatchQueue.main.async {
            callback()
        }
    }
    
}
