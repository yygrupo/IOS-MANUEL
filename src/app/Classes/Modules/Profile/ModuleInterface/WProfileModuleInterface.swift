//
//  WProfileModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

protocol WProfileModuleInterface
{
    func updateView()
    func updateUser(user: WUser)
    func logOut()
}

protocol WProfileModuleDelegate
{

}
