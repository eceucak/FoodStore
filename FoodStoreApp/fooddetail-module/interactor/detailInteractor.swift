//
//  detailInteractor.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 25.05.2022.
//

import Foundation
import Alamofire

class DetailInteractor : PresenterToInteractorDetailProtocol {
    func bringsFood(yemek_id: String, yemek_adi: String, yemek_fiyat: String) {
        print("yemekler geldi")
    }
    
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
  
}
    

