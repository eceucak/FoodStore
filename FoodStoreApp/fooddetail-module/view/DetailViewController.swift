//
//  DetailViewController.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import UIKit

import Alamofire
import Kingfisher
import UserNotifications



class DetailViewController: UIViewController, UNUserNotificationCenterDelegate{
    
    var permissionControl = false

    var food:Foods?
    var cart:Cart?
    

    @IBOutlet weak var numberFood: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var foodPrice: UILabel!
    
    var DetailPresenterNesnesi:ViewToPresenterDetailProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (granted,error) in
            self.permissionControl = granted
            
            if granted {
                print("Izin alma islemi basarili")
            }else{
                print("Izin alma islemi basarisiz")
            }
        })
        
       if let f = food {
           
           foodName.text = "\(f.yemek_adi!)"
           foodPrice.text = "\(f.yemek_fiyat!)"
           
           if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)"){
                foodImage.kf.setImage(with:url)
                }
        }
       
        
        DetailRouter.createModule(ref: self)
        
       
    }
    
    @IBAction func sepeteEkle(_ sender: Any) {
        
        if permissionControl {
            let icerik = UNMutableNotificationContent()
            icerik.title = "FoodStore"
            icerik.subtitle = "Kuponlarım"
            icerik.body = "10₺ kuponunuz bulunmaktadır! Kullanmak için tıklayınız."
            icerik.badge = 1 //artmasi icin userdefault
            icerik.sound = UNNotificationSound.default
            
            
            //saniye turu
            let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let bildirimIstegi = UNNotificationRequest(identifier: "Bildirim Kullanimi", content: icerik, trigger: tetikleme)
            
            UNUserNotificationCenter.current().add(bildirimIstegi, withCompletionHandler: nil)
            
        }
    
        
        if (Int(numberFood.text!) == nil || Int(numberFood.text!) == 0){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen Adet Seçiniz", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "Tamam", style: .cancel){ action in
                
            }
            alert.addAction(iptalAction)
            self.present(alert, animated: true)
            
        }else{
            
            if let ys = numberFood.text, let y = food, let yf = foodPrice.text {
                DetailPresenterNesnesi?.add(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: Int(yf) ?? 0, yemek_siparis_adet: Int(ys)!, kullanici_adi: "ece_ucak")
                
            }
            
            
        }
    }
   
    @IBAction func stepperDurum(_ sender: UIStepper) {
        numberFood.text = "\(Int(sender.value))"
    }
    
       
    }
   

extension ViewController:UNUserNotificationCenterDelegate {
    //on planda calismasi icin
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound,.badge])
        
        //bildirime tiklama
        
       
    }
}
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
            let app = UIApplication.shared
            
            if app.applicationState == .active {
                print("onplandayken bildirim tiklandi")
                app.applicationIconBadgeNumber = 0
            }
            if app.applicationState == .inactive {
                print("arkaplandayken bildirim tiklandi")
                app.applicationIconBadgeNumber = 0
            }
            completionHandler()
    }
        



    
