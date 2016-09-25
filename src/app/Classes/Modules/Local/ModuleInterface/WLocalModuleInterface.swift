//
//  WLocalModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

protocol WLocalModuleInterface
{
    func updateView()
    func presentLocalDetail(local: WLocal)
    func showMap()
    func findLocalsWithCategory(category: String)
}

protocol WLocalModuleDelegate
{

}
