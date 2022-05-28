//
//  myCartProtocols.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 26.05.2022.
//

import Foundation

protocol ViewToPresenterCartProtocol {
    var CartInteractor:PresenterToInteractorCartProtocol? {get set}
    var CartView:PresenterToViewCartProtocol? {get set}
    
    func loadCart()
    func delete(sepet_yemek_id:String,kullanici_adi:String)
}

protocol PresenterToInteractorCartProtocol {
    var CartPresenter:InteractorToPresenterCartProtocol? {get set}
    
    func getAllCart()
    func deleteFood(sepet_yemek_id:String,kullanici_adi:String)
}

protocol InteractorToPresenterCartProtocol {
    func sendDataToPresenter(cartList:Array<Cart>)
}

protocol PresenterToViewCartProtocol {
    func sendDataToView(cartList:Array<Cart>)
}

protocol PresenterToRouterCartProtocol {
    static func createModule(ref:MyCartViewController)
}
