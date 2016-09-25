//
//  WProfileInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation
import UIKit

class WProfileInteractor: NSObject
{
    weak var presenter: WProfilePresenter?
    var dataManager: WProfileDataManager?
    
    func findUser() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let user: String = userDefaults.stringForKey("lastUser")!
        
        let userFullName = userDefaults.stringForKey(user + "-fullname")
        let userPassword = userDefaults.stringForKey(user)
        let phoneNumber = userDefaults.stringForKey(user + "-phoneNumber")
        let userEmail = userDefaults.stringForKey(user + "-email")
        let userImageData = userDefaults.dataForKey(user + "-image")
        let userImage = UIImage(data: userImageData!)
        let userModel = WUser(userName: user, fullName: userFullName, email: userEmail, phoneNumber: phoneNumber, image: userImage, password: userPassword)
        WMainBoard.sharedInstance.currentUser = userModel
        
        presenter?.updateViewWithUser(userModel)
    }
    
    func updateUser(user: WUser) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setObject(user.password, forKey: user.email!)
        userDefaults.setObject(user.fullName, forKey: user.email! + "-fullname")
        userDefaults.setObject(user.email, forKey: user.email! + "-email")
        userDefaults.setObject(user.phoneNumber, forKey: user.email! + "-phoneNumber")
        
        let imageData = UIImageJPEGRepresentation(user.image!, 0.5)
        userDefaults.setObject(imageData, forKey: user.email! + "-image")
        userDefaults.setObject(user.email!, forKey: "lastUser")
        
        userDefaults.synchronize()
        WMainBoard.sharedInstance.currentUser = user
    }
    
    func logOut() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("lastUser")
        userDefaults.synchronize()
        WMainBoard.sharedInstance.currentUser = nil
        presenter?.logOut()
    }
}
