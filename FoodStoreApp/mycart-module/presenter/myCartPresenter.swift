//
//  myCartPresenter.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 26.05.2022.
//

import Foundation

class CartPresenter : ViewToPresenterCartProtocol {

    var CartInteractor: PresenterToInteractorCartProtocol?
    var CartView: PresenterToViewCartProtocol?
    
    func loadCart() {
        CartInteractor?.getAllCart()
    }
  
    func delete(sepet_yemek_id:String,kullanici_adi:String) {
        CartInteractor?.deleteFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}

extension CartPresenter : InteractorToPresenterCartProtocol {
    func sendDataToPresenter(cartList: Array<Cart>) {
        CartView?.sendDataToView(cartList: cartList)
    }
}
