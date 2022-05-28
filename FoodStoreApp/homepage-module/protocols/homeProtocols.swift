//
//  homeProtocols.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import Foundation

protocol ViewToPresenterHomeProtocol {
    var homeInteractor:PresenterToInteractorHomeProtocol? {get set}
    var homeView:PresenterToViewHomeProtocol? {get set}
    func add(yemek_adi: String,yemek_resim_adi: String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
    
    func bringsFoods()
}

protocol PresenterToInteractorHomeProtocol {
    var homePresenter:InteractorToPresenterHomeProtocol? {get set}
    func addToCart(yemek_adi: String,yemek_resim_adi: String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
    
    func getAllFoods()
   
}

protocol InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foodList:Array<Foods>)
}

protocol PresenterToViewHomeProtocol {
    func sendDataToView(foodList:Array<Foods>)
}

protocol PresenterToRouterHomeProtocol {
    static func createModule(ref:HomeViewController)
}
