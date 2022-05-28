//
//  homePresenter.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import Foundation

class HomePresenter : ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteractorHomeProtocol?
    var homeView: PresenterToViewHomeProtocol?
    
    func add(yemek_adi: String,yemek_resim_adi: String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String) {
        homeInteractor?.addToCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat:yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)}
    func bringsFoods() {
        homeInteractor?.getAllFoods()
    }

}

extension HomePresenter : InteractorToPresenterHomeProtocol {
    
    func sendDataToPresenter(foodList: Array<Foods>) {
        homeView?.sendDataToView(foodList:foodList)
    }
    
}
