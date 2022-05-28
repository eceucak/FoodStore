//
//  homeInteractor.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import Foundation
import Alamofire

class HomeInteractor : PresenterToInteractorHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    
    func addToCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let params:Parameters = ["yemek_adi":yemek_adi,
                                 "yemek_resim_adi":yemek_resim_adi,
                                 "yemek_fiyat":yemek_fiyat,
                                 "yemek_siparis_adet":yemek_siparis_adet,
                                 "kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
   
    
    func getAllFoods() {
         AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).responseJSON{ response in
                
                if let data = response.data {
                    do{
                        let responses = try JSONDecoder().decode(FoodsResponse.self, from: data)
                        var list = [Foods]()
                        if let incomingList = responses.yemekler {
                            list = incomingList
                        }
                        
                        self.homePresenter?.sendDataToPresenter(foodList:list)
                       
                        
                       }catch{
                        print(error.localizedDescription)
                    }
                }
           }
       }
   }
