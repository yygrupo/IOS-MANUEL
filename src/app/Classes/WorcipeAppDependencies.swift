//
//  WorcipeAppDependencies.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import UIKit
import GoogleMaps
import IQKeyboardManagerSwift

class WorcipeAppDependencies: NSObject
{
    var dataStore : WCoreDataStore?
    var startWireframe: WStartWireframe?

    class func initWithWindow(window: UIWindow) -> WorcipeAppDependencies
    {

        let obj = WorcipeAppDependencies()
        obj.configureDependencies(window)
        WMainBoard.sharedInstance.startUpdatingLocation()
        
        IQKeyboardManager.sharedManager().enable = true
        
        GMSServices.provideAPIKey(AppAPI.googleMaps)

        return obj
    }

    func installRootViewController()
    {
        // *** present first wireframe here
//        homeWireframe?.presentSelfViewControllerAsRootViewController()
        startWireframe?.presentSelfViewControllerAsRootViewController()
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
        let homeWireframe: WHomeWireframe      = WHomeWireframe()
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
        // begin LocalProfile module
        
        // instantiate classes
        let localprofileWireframe: WLocalProfileWireframe      = WLocalProfileWireframe()
        let localprofilePresenter: WLocalProfilePresenter      = WLocalProfilePresenter()
        let localprofileDataManager: WLocalProfileDataManager  = WLocalProfileDataManager()
        let localprofileInteractor: WLocalProfileInteractor    = WLocalProfileInteractor()
        
        // ------------------------------------------------------------------
        // begin RecipeProfile module
        
        // instantiate classes
        let recipeprofileWireframe: WRecipeProfileWireframe      = WRecipeProfileWireframe()
        let recipeprofilePresenter: WRecipeProfilePresenter      = WRecipeProfilePresenter()
        let recipeprofileDataManager: WRecipeProfileDataManager  = WRecipeProfileDataManager()
        let recipeprofileInteractor: WRecipeProfileInteractor    = WRecipeProfileInteractor()
        
        // ------------------------------------------------------------------
        // begin RecipeRated module
        
        // instantiate classes
        let reciperatedWireframe: WRecipeRatedWireframe      = WRecipeRatedWireframe()
        let reciperatedPresenter: WRecipeRatedPresenter      = WRecipeRatedPresenter()
        let reciperatedDataManager: WRecipeRatedDataManager  = WRecipeRatedDataManager()
        let reciperatedInteractor: WRecipeRatedInteractor    = WRecipeRatedInteractor()
        
        // ------------------------------------------------------------------
        // begin News module
        
        // instantiate classes
        let newsWireframe: WNewsWireframe      = WNewsWireframe()
        let newsPresenter: WNewsPresenter      = WNewsPresenter()
        let newsDataManager: WNewsDataManager  = WNewsDataManager()
        let newsInteractor: WNewsInteractor    = WNewsInteractor()
        
        // ------------------------------------------------------------------
        // begin About module
        
        // instantiate classes
        let aboutWireframe: WAboutWireframe      = WAboutWireframe()
        let aboutPresenter: WAboutPresenter      = WAboutPresenter()
        let aboutDataManager: WAboutDataManager  = WAboutDataManager()
        let aboutInteractor: WAboutInteractor    = WAboutInteractor()
        
        // ------------------------------------------------------------------
        // begin Terms module
        
        // instantiate classes
        let termsWireframe: WTermsWireframe      = WTermsWireframe()
        let termsPresenter: WTermsPresenter      = WTermsPresenter()
        let termsDataManager: WTermsDataManager  = WTermsDataManager()
        let termsInteractor: WTermsInteractor    = WTermsInteractor()
        
        // ------------------------------------------------------------------
        // begin Taste module
        
        // instantiate classes
        let tasteWireframe: WTasteWireframe      = WTasteWireframe()
        let tastePresenter: WTastePresenter      = WTastePresenter()
        let tasteDataManager: WTasteDataManager  = WTasteDataManager()
        let tasteInteractor: WTasteInteractor    = WTasteInteractor()
        
        // ------------------------------------------------------------------
        // begin SearchResult module
        
        // instantiate classes
        let searchresultWireframe: WSearchResultWireframe      = WSearchResultWireframe()
        let searchresultPresenter: WSearchResultPresenter      = WSearchResultPresenter()
        let searchresultDataManager: WSearchResultDataManager  = WSearchResultDataManager()
        let searchresultInteractor: WSearchResultInteractor    = WSearchResultInteractor()
        
        // ------------------------------------------------------------------
        // begin Start module
        
        // instantiate classes
        startWireframe      = WStartWireframe()
        let startPresenter: WStartPresenter      = WStartPresenter()
        let startDataManager: WStartDataManager  = WStartDataManager()
        let startInteractor: WStartInteractor    = WStartInteractor()
        
        // ------------------------------------------------------------------
        // begin Home module
        // presenter <-> wireframe
        homePresenter.wireframe = homeWireframe
        homeWireframe.presenter = homePresenter
        // presenter <-> interactor
        homePresenter.interactor = homeInteractor
        homeInteractor.presenter = homePresenter
        // interactor -> data_manager
        homeInteractor.dataManager = homeDataManager
        // data_manager -> data_store
        homeDataManager.dataStore = dataStore
        // *** connect datastore
        // connect wireframes
        homeWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        homeWireframe.recipeprofileWireframe = recipeprofileWireframe
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
        menuWireframe.reciperatedWireframe = reciperatedWireframe
        menuWireframe.newsWireframe = newsWireframe
        menuWireframe.aboutWireframe = aboutWireframe
        menuWireframe.termsWireframe = termsWireframe
        menuWireframe.tasteWireframe = tasteWireframe
        menuWireframe.profileWireframe = profileWireframe
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
        localDataManager.dataStore = dataStore
        // connect wireframes
        localWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        localWireframe.localprofileWireframe = localprofileWireframe
        localWireframe.mapWireframe = mapWireframe
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
        searchDataManager.dataStore = dataStore
        // connect wireframes
        searchWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        searchWireframe.searchresultWireframe = searchresultWireframe
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
        loginWireframe.profileWireframe = profileWireframe
        loginWireframe.registerWireframe = registerWireframe
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
        registerWireframe.profileWireframe = profileWireframe
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
        profileWireframe.loginWireframe = loginWireframe
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
        mapDataManager.dataStore = dataStore
        // connect wireframes
        mapWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        // configure delegate
        // *** add delegate here if needed
        // end Map module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin LocalProfile module
        
        // presenter <-> wireframe
        localprofilePresenter.wireframe = localprofileWireframe
        localprofileWireframe.presenter = localprofilePresenter
        
        // presenter <-> interactor
        localprofilePresenter.interactor = localprofileInteractor
        localprofileInteractor.presenter = localprofilePresenter
        
        // interactor -> data_manager
        localprofileInteractor.dataManager = localprofileDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        localprofileDataManager.dataStore = dataStore
        // connect wireframes
        localprofileWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end LocalProfile module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin LocalProfile module
        
        // presenter <-> wireframe
        localprofilePresenter.wireframe = localprofileWireframe
        localprofileWireframe.presenter = localprofilePresenter
        
        // presenter <-> interactor
        localprofilePresenter.interactor = localprofileInteractor
        localprofileInteractor.presenter = localprofilePresenter
        
        // interactor -> data_manager
        localprofileInteractor.dataManager = localprofileDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        
        // connect wireframes
        localprofileWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end LocalProfile module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin RecipeProfile module
        
        // presenter <-> wireframe
        recipeprofilePresenter.wireframe = recipeprofileWireframe
        recipeprofileWireframe.presenter = recipeprofilePresenter
        
        // presenter <-> interactor
        recipeprofilePresenter.interactor = recipeprofileInteractor
        recipeprofileInteractor.presenter = recipeprofilePresenter
        
        // interactor -> data_manager
        recipeprofileInteractor.dataManager = recipeprofileDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        recipeprofileDataManager.dataStore = dataStore
        // connect wireframes
        recipeprofileWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        recipeprofileWireframe.localprofileWireframe = localprofileWireframe
        // configure delegate
        // *** add delegate here if needed
        
        // end LocalProfile module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin RecipeRated module
        
        // presenter <-> wireframe
        reciperatedPresenter.wireframe = reciperatedWireframe
        reciperatedWireframe.presenter = reciperatedPresenter
        
        // presenter <-> interactor
        reciperatedPresenter.interactor = reciperatedInteractor
        reciperatedInteractor.presenter = reciperatedPresenter
        
        // interactor -> data_manager
        reciperatedInteractor.dataManager = reciperatedDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        reciperatedDataManager.dataStore = dataStore
        // connect wireframes
        reciperatedWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        reciperatedWireframe.recipeprofileWireframe = recipeprofileWireframe
        // configure delegate
        // *** add delegate here if needed
        
        // end RecipeRated module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin News module
        
        // presenter <-> wireframe
        newsPresenter.wireframe = newsWireframe
        newsWireframe.presenter = newsPresenter
        
        // presenter <-> interactor
        newsPresenter.interactor = newsInteractor
        newsInteractor.presenter = newsPresenter
        
        // interactor -> data_manager
        newsInteractor.dataManager = newsDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        
        // connect wireframes
        newsWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end News module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin About module
        
        // presenter <-> wireframe
        aboutPresenter.wireframe = aboutWireframe
        aboutWireframe.presenter = aboutPresenter
        
        // presenter <-> interactor
        aboutPresenter.interactor = aboutInteractor
        aboutInteractor.presenter = aboutPresenter
        
        // interactor -> data_manager
        aboutInteractor.dataManager = aboutDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        
        // connect wireframes
        aboutWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end About module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Terms module
        
        // presenter <-> wireframe
        termsPresenter.wireframe = termsWireframe
        termsWireframe.presenter = termsPresenter
        
        // presenter <-> interactor
        termsPresenter.interactor = termsInteractor
        termsInteractor.presenter = termsPresenter
        
        // interactor -> data_manager
        termsInteractor.dataManager = termsDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        
        // connect wireframes
        termsWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end Terms module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Taste module
        
        // presenter <-> wireframe
        tastePresenter.wireframe = tasteWireframe
        tasteWireframe.presenter = tastePresenter
        
        // presenter <-> interactor
        tastePresenter.interactor = tasteInteractor
        tasteInteractor.presenter = tastePresenter
        
        // interactor -> data_manager
        tasteInteractor.dataManager = tasteDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        tasteDataManager.dataStore = dataStore
        // connect wireframes
        tasteWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        tasteWireframe.recipeprofileWireframe = recipeprofileWireframe
        // configure delegate
        // *** add delegate here if needed
        
        // end Taste module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin SearchResult module
        
        // presenter <-> wireframe
        searchresultPresenter.wireframe = searchresultWireframe
        searchresultWireframe.presenter = searchresultPresenter
        
        // presenter <-> interactor
        searchresultPresenter.interactor = searchresultInteractor
        searchresultInteractor.presenter = searchresultPresenter
        
        // interactor -> data_manager
        searchresultInteractor.dataManager = searchresultDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        searchresultDataManager.dataStore = dataStore
        // connect wireframes
        searchresultWireframe.rootWireframe = rootWireframe
        // *** connect more wireframes
        searchresultWireframe.recipeprofileWireframe = recipeprofileWireframe
        // configure delegate
        // *** add delegate here if needed
        
        // end SearchResult module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin Start module
        
        // presenter <-> wireframe
        startPresenter.wireframe = startWireframe
        startWireframe!.presenter = startPresenter
        
        // presenter <-> interactor
        startPresenter.interactor = startInteractor
        startInteractor.presenter = startPresenter
        
        // interactor -> data_manager
        startInteractor.dataManager = startDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        
        // connect wireframes
        startWireframe!.rootWireframe = rootWireframe
        // *** connect more wireframes
        startWireframe?.homeWireframe = homeWireframe
        // configure delegate
        // *** add delegate here if needed
        
        // end Start module
        // ------------------------------------------------------------------
    }
}
