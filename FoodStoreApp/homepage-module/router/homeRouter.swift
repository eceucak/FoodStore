//
//  homeRouter.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import Foundation

class HomeRouter : PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeViewController) {
        let presenter : ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        
        ref.homePresenterNesnesi = presenter
        
       
        ref.homePresenterNesnesi?.homeInteractor = HomeInteractor()
        ref.homePresenterNesnesi?.homeView = ref
        
        
        ref.homePresenterNesnesi?.homeInteractor?.homePresenter = presenter
    }
 
}
