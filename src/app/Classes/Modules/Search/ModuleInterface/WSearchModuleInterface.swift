//
//  WSearchModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

protocol WSearchModuleInterface
{
    func updateView()
    func doSearchWithCriteria(searchCriteria: WSearchCriteria)
}

protocol WSearchModuleDelegate
{

}
