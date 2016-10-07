
//
//  SessionManager.swift
//  SoundMe
//
//  Created by Hercules on 9/16/16.
//  Copyright © 2016 dror gal. All rights reserved.
//

import Foundation

public class SessionManager {
    
    
    private let appSessionArchiveURL = ""//Globals.DocumentsDirectory.URLByAppendingPathComponent("AppSession")
    private let accountArchiveURL = ""//Globals.DocumentsDirectory.URLByAppendingPathComponent("Account")
    
    private var isLoggedIn = false
    
    private init () {
       // loadSessions()
        //loadAccount()
    }
    
//    public func changeAppSession(appSession : AppSession) -> Bool {
//        self.appSession = appSession
//        if saveSessions() == false{
//            return false
//        }
//        else{
//            return true
//        }
//    }
    
    public func getAppSession() -> AppSession? {
        return appSession
    }
    
//    public func rememberAccount(account : Account) -> Bool {
//        self.account = account
//        if saveAccount() == false{
//            return false
//        }
//        else{
//            return true
//        }
//    }
//    
//    public func forgetAccount() -> Bool{
//        self.account = nil
//        if saveAccount() == false{
//            return false
//        } else{
//            return true
//        }
//    }
//    
    
    func getAccount() -> Account? {
        return account
    }
    
    static let Instance = SessionManager()
    
    private var appSession : AppSession?
    private var account : Account?
    
    
//    private func saveSessions()->Bool {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(appSession!, toFile: appSessionArchiveURL.path!)
//        if !isSuccessfulSave {
//            return false
//        }
//        else{
//            return true
//        }
//        
//    }
//    
//    private func loadSessions() {
//        appSession = NSKeyedUnarchiver.unarchiveObjectWithFile(appSessionArchiveURL.path!) as? AppSession
//    }
//    
//    
//    private func saveAccount()->Bool {
//        if account == nil {
//            do {
//                try FileManager.defaultManager.removeItemAtPath(accountArchiveURL.path!)
//            } catch {
//                
//            }
//            return true
//        } else {
//            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(account!, toFile: accountArchiveURL.path!)
//            if !isSuccessfulSave {
//                return false
//            } else{
//                return true
//            }
//        }
//        
//    }
//    
//    private func loadAccount() {
//        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountArchiveURL.path!) as? Account
//    }
//    
    open func loginUser(_ email:String, password:String,callback:@escaping (_ success:Bool)->()){
        API.login(email, password: password) { (success, result) -> () in
            if success
            {
                UserManger.Instance.getLoginUser(sessionKey: "", callback: { (Bool) in
                    if Bool{
                        UserManger.Instance.getUsers(sessionKey: "", callback: { (Bool) in
                            if Bool{
                                callback(true)
                            }else{
                                callback(false)
                            }
                        })
                    }else{
                        callback(false)
                    }
                })
                
            }
                
            else
            {
                callback(false)
            }
        }
    }
    
//    private var loginNotifiers : Dictionary<String,NotifierCallback> = Dictionary<String,NotifierCallback>()
//    
//    open func registerLoginNotifier(name:String, notifier:NotifierCallback) {
//        loginNotifiers[name] = notifier
//    }
//    
//    public func unregisterLoginNotifier(name:String) {
//        loginNotifiers.removeValueForKey(name)
//    }
//
//    private var logoutNotifiers : Dictionary<String,NotifierCallback> = Dictionary<String,NotifierCallback>()
//    
//    public func registerLogoutNotifier(name:String, notifier:NotifierCallback) {
//        logoutNotifiers[name] = notifier
//    }
//    
//    public func unregisterLogoutNotifier(name:String) {
//        logoutNotifiers.removeValueForKey(name)
//    }
//    
 
    
}
