//
//  WLoginModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

protocol WLoginModuleInterface
{
    func doLogin(user: String, password: String)
    func showRegisterForm()
}

protocol WLoginModuleDelegate
{

}
