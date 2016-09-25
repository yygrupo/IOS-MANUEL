//
//  WLoginInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation
import UIKit

class WLoginInteractor: NSObject
{
    weak var presenter: WLoginPresenter?
    var dataManager: WLoginDataManager?
    
    func doLogin(user: String, password: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.stringForKey(user) == nil {
            presenter?.userNotFound()
            return
        }
        
        if userDefaults.stringForKey(user) != password {
            presenter?.wrongPassword()
            return
        }
        
        let userFullName = userDefaults.stringForKey(user + "-fullname")
        let userPassword = userDefaults.stringForKey(user)
        let phoneNumber = userDefaults.stringForKey(user + "-phoneNumber")
        let userEmail = userDefaults.stringForKey(user + "-email")
        let userImageData = userDefaults.dataForKey(user + "-image")
        let userImage = UIImage(data: userImageData!)
        let userModel = WUser(userName: user, fullName: userFullName, email: userEmail, phoneNumber: phoneNumber, image: userImage, password: userPassword)
        WMainBoard.sharedInstance.currentUser = userModel
        userDefaults.setObject(user, forKey: "lastUser")
        userDefaults.synchronize()
        
        presenter?.userFound()
    }
}
