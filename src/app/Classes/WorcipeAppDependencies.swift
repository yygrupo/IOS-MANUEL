//
//  WorcipeAppDependencies.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import UIKit

class WorcipeAppDependencies: NSObject
{
    var dataStore : WCoreDataStore?
    var homeWireframe: WHomeWireframe?

    class func initWithWindow(window: UIWindow) -> WorcipeAppDependencies
    {

        let obj = WorcipeAppDependencies()
        obj.configureDependencies(window)

        return obj
    }

    func installRootViewController()
    {
        // *** present first wireframe here
        homeWireframe?.presentSelfViewControllerAsRootViewController()
    }

    func configureDependencies(window: UIWindow)
    {
        // -----
        // root classes
        let rootWireframe = RootWireframe.init(window: window)
        // *** add datastore
        dataStore = WCoreDataStore()

        // *** module initialization
        
        // ------------------------------------------------------------------
        // begin Home module
        
        // instantiate classes
        homeWireframe      = WHomeWireframe()
        let homePresenter: WHomePresenter      = WHomePresenter()
        let homeDataManager: WHomeDataManager  = WHomeDataManager()
        let homeInteractor: WHomeInteractor    = WHomeInteractor()
        
        // ------------------------------------------------------------------
        // begin Menu module
        
        // instantiate classes
        let menuWireframe: WMenuWireframe      = WMenuWireframe()
        let menuPresenter: WMenuPresenter      = WMenuPresenter()
        let menuDataManager: WMenuDataManager  = WMenuDataManager()
        let menuInteractor: WMenuInteractor    = WMenuInteractor()
        
        // ------------------------------------------------------------------
        // begin Local module
        
        // instantiate classes
        let localWireframe: WLocalWireframe      = WLocalWireframe()
        let localPresenter: WLocalPresenter      = WLocalPresenter()
        let localDataManager: WLocalDataManager  = WLocalDataManager()
        let localInteractor: WLocalInteractor    = WLocalInteractor()
        
        // ------------------------------------------------------------------
        // begin Rate module
        
        // instantiate classes
        let rateWireframe: WRateWireframe      = WRateWireframe()
        let ratePresenter: WRatePresenter      = WRatePresenter()
        let rateDataManager: WRateDataManager  = WRateDataManager()
        let rateInteractor: WRateInteractor    = WRateInteractor()
        
        // ------------------------------------------------------------------
        // begin Search module
        
        // instantiate classes
        let searchWireframe: WSearchWireframe      = WSearchWireframe()
        let searchPresenter: WSearchPresenter      = WSearchPresenter()
        let searchDataManager: WSearchDataManager  = WSearchDataManager()
        let searchInteractor: WSearchInteractor    = WSearchInteractor()
        
        // ------------------------------------------------------------------
        // begin Login module
        
        // instantiate classes
        let loginWireframe: WLoginWireframe      = WLoginWireframe()
        let loginPresenter: WLoginPresenter      = WLoginPresenter()
        let loginDataManager: WLoginDataManager  = WLoginDataManager()
        let loginInteractor: WLoginInteractor    = WLoginInteractor()
        
        // ------------------------------------------------------------------
        // begin Register module
        
        // instantiate classes
        let registerWireframe: WRegisterWireframe      = WRegisterWireframe()
        let registerPresenter: WRegisterPresenter      = WRegisterPresenter()
        let registerDataManager: WRegisterDataManager  = WRegisterDataManager()
        let registerInteractor: WRegisterInteractor    = WRegisterInteractor()
        
        // ------------------------------------------------------------------
        // begin Profile module
        
        // instantiate classes
        let profileWireframe: WProfileWireframe      = WProfileWireframe()
        let profilePresenter: WProfilePresenter      = WProfilePresenter()
        let profileDataManager: WProfileDataManager  = WProfileDataManager()
        let profileInteractor: WProfileInteractor    = WProfileInteractor()
        
        // ------------------------------------------------------------------
        // begin Map module
        
        // instantiate classes
        let mapWireframe: WMapWireframe      = WMapWireframe()
        let mapPresenter: WMapPresenter      = WMapPresenter()
        let mapDataManager: WMapDataManager  = WMapDataManager()
        let mapInteractor: WMapInteractor    = WMapInteractor()
        
        // ------------------------------------------------------------------
        // begin Home module
        // presenter <-> wireframe
        homePresenter.wireframe = homeWireframe
        homeWireframe!.presenter = homePresenter
        // presenter <-> interactor
        homePresenter.interactor = homeInteractor
        homeInteractor.presenter = homePresenter
        // interactor -> data_manager
        homeInteractor.dataManager = homeDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        homeWireframe!.rootWireframe = rootWireframe
        // *** connect more wireframes
        rootWireframe.homeWireframe = homeWireframe
        // configure delegate
        // *** add delegate here if needed
        // end Home module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Menu module
        // presenter <-> wireframe
        menuPresenter.wireframe = menuWireframe
        menuWireframe.presenter = menuPresenter
        // presenter <-> interactor
        menuPresenter.interactor = menuInteractor
        menuInteractor.presenter = menuPresenter
        // interactor -> data_manager
        menuInteractor.dataManager = menuDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        menuWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        rootWireframe.menuWireframe = menuWireframe
        menuWireframe.homeWireframe = homeWireframe
        menuWireframe.localWireframe = localWireframe
        menuWireframe.loginWireframe = loginWireframe
        menuWireframe.rateWireframe = rateWireframe
        menuWireframe.registerWireframe = registerWireframe
        menuWireframe.searchWireframe = searchWireframe
        menuWireframe.profileWireframe = profileWireframe
        menuWireframe.mapWireframe = mapWireframe
        // configure delegate
        // *** add delegate here if needed
        // end Menu module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Local module
        // presenter <-> wireframe
        localPresenter.wireframe = localWireframe
        localWireframe.presenter = localPresenter
        // presenter <-> interactor
        localPresenter.interactor = localInteractor
        localInteractor.presenter = localPresenter
        // interactor -> data_manager
        localInteractor.dataManager = localDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        localWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Local module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Rate module
        // presenter <-> wireframe
        ratePresenter.wireframe = rateWireframe
        rateWireframe.presenter = ratePresenter
        // presenter <-> interactor
        ratePresenter.interactor = rateInteractor
        rateInteractor.presenter = ratePresenter
        // interactor -> data_manager
        rateInteractor.dataManager = rateDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        rateWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Rate module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Search module
        // presenter <-> wireframe
        searchPresenter.wireframe = searchWireframe
        searchWireframe.presenter = searchPresenter
        // presenter <-> interactor
        searchPresenter.interactor = searchInteractor
        searchInteractor.presenter = searchPresenter
        // interactor -> data_manager
        searchInteractor.dataManager = searchDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        searchWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Search module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Login module
        // presenter <-> wireframe
        loginPresenter.wireframe = loginWireframe
        loginWireframe.presenter = loginPresenter
        // presenter <-> interactor
        loginPresenter.interactor = loginInteractor
        loginInteractor.presenter = loginPresenter
        // interactor -> data_manager
        loginInteractor.dataManager = loginDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        loginWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Login module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Register module
        // presenter <-> wireframe
        registerPresenter.wireframe = registerWireframe
        registerWireframe.presenter = registerPresenter
        // presenter <-> interactor
        registerPresenter.interactor = registerInteractor
        registerInteractor.presenter = registerPresenter
        // interactor -> data_manager
        registerInteractor.dataManager = registerDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        registerWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Register module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Profile module
        // presenter <-> wireframe
        profilePresenter.wireframe = profileWireframe
        profileWireframe.presenter = profilePresenter
        // presenter <-> interactor
        profilePresenter.interactor = profileInteractor
        profileInteractor.presenter = profilePresenter
        // interactor -> data_manager
        profileInteractor.dataManager = profileDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        profileWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Profile module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Map module
        // presenter <-> wireframe
        mapPresenter.wireframe = mapWireframe
        mapWireframe.presenter = mapPresenter
        // presenter <-> interactor
        mapPresenter.interactor = mapInteractor
        mapInteractor.presenter = mapPresenter
        // interactor -> data_manager
        mapInteractor.dataManager = mapDataManager
        // data_manager -> data_store
        // *** connect datastore
        // connect wireframes
        mapWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Map module
        // ------------------------------------------------------------------
    }
}
