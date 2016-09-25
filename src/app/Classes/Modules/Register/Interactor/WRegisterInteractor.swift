//
//  WRegisterInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation
import UIKit

class WRegisterInteractor: NSObject
{
    weak var presenter: WRegisterPresenter?
    var dataManager: WRegisterDataManager?
    
    func registerUser(user: WUser) {
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
        
        presenter?.userRegistered()
    }
}
