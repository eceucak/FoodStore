//
//  detailProtocols.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 25.05.2022.
//

import Foundation

protocol ViewToPresenterDetailProtocol {
    var DetailInteractor:PresenterToInteractorDetailProtocol? {get set}
    
    func brings(yemek_id:String,yemek_adi:String,yemek_fiyat:String)
    
    func add(yemek_adi: String,yemek_resim_adi: String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol PresenterToInteractorDetailProtocol {
    func bringsFood(yemek_id:String,yemek_adi:String,yemek_fiyat:String)
    
    func addToCart(yemek_adi: String,yemek_resim_adi: String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol PresenterToRouterDetailProtocol {
    static func createModule(ref:DetailViewController)
}
