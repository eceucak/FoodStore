//
//  detailRouter.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 25.05.2022.
//

import Foundation
class DetailRouter : PresenterToRouterDetailProtocol {
    static func createModule(ref: DetailViewController) {
        
        ref.DetailPresenterNesnesi = DetailPresenter()
        ref.DetailPresenterNesnesi?.DetailInteractor = DetailInteractor()
        
    }
}
