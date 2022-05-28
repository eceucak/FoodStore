//
//  myCartInteractor.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 26.05.2022.
//

import Foundation
import Alamofire

class CartInteractor : PresenterToInteractorCartProtocol {
 
    func getAllCart() {
        let params:Parameters=["kullanici_adi":"ece_ucak"]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    let responses = try JSONDecoder().decode(CartResponse.self, from: data)
                    var list = [Cart]()
                    if let incomingList = responses.sepet_yemekler {
                        list = incomingList
                    }
                    
                   self.CartPresenter?.sendDataToPresenter(cartList: list)
                   
                    
                }catch{
                    print(error.localizedDescription)
                    self.CartPresenter?.sendDataToPresenter(cartList: [])
                }
            }
            
        }
    }
    
    var CartPresenter: InteractorToPresenterCartProtocol?
    func deleteFood(sepet_yemek_id: String, kullanici_adi: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":"ece_ucak"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.getAllCart()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    }
    
    

  
    
    
