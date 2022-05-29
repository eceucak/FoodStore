//
//  MyCartViewController.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 26.05.2022.
//

import UIKit
import Alamofire

class MyCartViewController: UIViewController {

    @IBOutlet weak var sepetButton: UIButton!
    @IBOutlet weak var badge: UITabBarItem!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var emptyCart: UIView!
    
    var myCartList = [Cart]()
    var CartPresenterNesnesi:ViewToPresenterCartProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCartTableView.delegate = self
        myCartTableView.dataSource = self
        emptyCart.isHidden = true
    
        CartRouter.createModule(ref: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CartPresenterNesnesi?.loadCart()
        topla()
    }
    
    func topla(){
        var sum = 0
        var fiyat = 0
        var sayac = 0
        while sayac < myCartList.count {
            fiyat = Int(myCartList[sayac].yemek_fiyat!)! * Int(myCartList[sayac].yemek_siparis_adet!)!
            sum += fiyat
            sayac += 1
        }
        totalPrice.text = "Toplam Tutar: \(sum) ₺"
    }
      
}

 
extension MyCartViewController : PresenterToViewCartProtocol {
    func sendDataToView(cartList: Array<Cart>) {
        
        self.myCartList = cartList
        DispatchQueue.main.async {
            
            self.myCartTableView.reloadData()
            self.topla()
            self.badge.badgeValue = "\(cartList.count)"
        }
    }
}

extension MyCartViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (myCartList.count == 0){
            emptyCart.isHidden = false
        }else{
            emptyCart.isHidden = true
            
        }
        return myCartList.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cart = myCartList[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell", for: indexPath) as! MyCartTableViewCell
         cell.cellFoodPrice.text = "\(cart.yemek_fiyat!) ₺"
         cell.cellFoodName.text = cart.yemek_adi
    let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cart.yemek_resim_adi!)")
    cell.cellImageView.kf.setImage(with: url)
         cell.selectionStyle = .none
    cell.cellFoodNumber.text = "\(cart.yemek_siparis_adet!) Adet"
    
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            
            let myCart = self.myCartList[indexPath.row]
            
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(myCart.yemek_adi!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in
                
            }
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.CartPresenterNesnesi?.delete(sepet_yemek_id: myCart.sepet_yemek_id!, kullanici_adi: myCart.kullanici_adi!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
    


