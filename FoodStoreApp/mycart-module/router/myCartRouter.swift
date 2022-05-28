//
//  myCartRouter.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 26.05.2022.
//

import Foundation

class CartRouter : PresenterToRouterCartProtocol {
    static func createModule(ref: MyCartViewController) {
        let presenter : ViewToPresenterCartProtocol & InteractorToPresenterCartProtocol = CartPresenter()
        
        //View controller için
        ref.CartPresenterNesnesi = presenter
        
        //Presenter için
        ref.CartPresenterNesnesi?.CartInteractor = CartInteractor()
        ref.CartPresenterNesnesi?.CartView = ref
        
        //Interactor için
        ref.CartPresenterNesnesi?.CartInteractor?.CartPresenter = presenter
    }
}
