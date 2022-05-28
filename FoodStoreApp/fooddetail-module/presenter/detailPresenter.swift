//
//  detailPresenter.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 25.05.2022.
//

import Foundation
class DetailPresenter : ViewToPresenterDetailProtocol {
   
    
   var DetailInteractor: PresenterToInteractorDetailProtocol?
    
    func add(yemek_adi: String,yemek_resim_adi: String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String) {
        DetailInteractor?.addToCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func brings(yemek_id: String, yemek_adi: String, yemek_fiyat: String) {
        DetailInteractor?.bringsFood(yemek_id: yemek_id, yemek_adi: yemek_adi, yemek_fiyat: yemek_fiyat)
    }
    
   
   
    
}
