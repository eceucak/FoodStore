//
//  HomeViewController.swift
//  FoodStore
//
//  Created by Ece Ucak on 23.05.2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var foodsCollectionView: UICollectionView!
    @IBOutlet weak var networkView: UIView!
    @IBOutlet weak var headLabel1: UILabel!
    @IBOutlet weak var headLabel2: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var headImage: UIImageView!
    
    var foodsList = [Foods]()
    var categories = [Categories]()
    var filteredFoodsList = [Foods]()
    
    
    var homePresenterNesnesi:ViewToPresenterHomeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkConnectionCheck.shared.isConnected {
            
            HomeRouter.createModule(ref: self)
            foodsCollectionView?.delegate = self
            foodsCollectionView?.dataSource = self
            categoriesCollectionView?.delegate = self
            categoriesCollectionView?.dataSource = self
            foodSearchBar.delegate = self
            
            warningView?.isHidden = true
            networkView?.isHidden = true
            
            let c1 = Categories(category_name: "Burger", category_image: "burger")
            let c2 = Categories(category_name: "Pizza", category_image: "pizza")
            let c3 = Categories(category_name: "Döner", category_image: "durum")
            let c4 = Categories(category_name: "Tatlılar", category_image: "tatli")
            let c5 = Categories(category_name: "İçecekler", category_image: "icecek")
            
            categories.append(c1)
            categories.append(c2)
            categories.append(c3)
            categories.append(c4)
            categories.append(c5)
            
            let design = UICollectionViewFlowLayout()
            design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            design.minimumInteritemSpacing = 10
            design.minimumLineSpacing = 10
            let width = self.foodsCollectionView.frame.size.width
            let cellWidth = (width - 40) / 4
            design.itemSize = CGSize(width: cellWidth * 1.3, height: cellWidth * 1.8)
            foodsCollectionView.collectionViewLayout = design
            
            let categoryDesign = UICollectionViewFlowLayout()
            categoryDesign.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            categoryDesign.minimumInteritemSpacing = 10
            categoryDesign.minimumLineSpacing = 10
            let categoryWidth = self.categoriesCollectionView.frame.size.width
            categoryDesign.scrollDirection = .horizontal
            let categoryCellWidth = (categoryWidth - 40) / 4
            categoryDesign.itemSize = CGSize(width: categoryCellWidth, height: categoryCellWidth)
            categoriesCollectionView.collectionViewLayout = categoryDesign
            
         
            print("******************************************************** CONNECTED ********************************************************")
        }else{
            foodSearchBar.isHidden = true
            foodsCollectionView.isHidden = true
            categoriesCollectionView.isHidden = true
            headImage.isHidden = true
            headLabel1.isHidden = true
            headLabel2.isHidden = true
            warningView?.isHidden = true
            networkView?.isHidden = false
            mapButton.isHidden = true
            print("******************************************************** NOT CONNECTED******************************************************")
        }
       

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NetworkConnectionCheck.shared.isConnected {
            homePresenterNesnesi?.bringsFoods()
            networkView?.isHidden = true
        }else{
            foodSearchBar.isHidden = true
            foodsCollectionView.isHidden = true
            categoriesCollectionView.isHidden = true
            headImage.isHidden = true
            headLabel1.isHidden = true
            headLabel2.isHidden = true
            warningView?.isHidden = true
            networkView?.isHidden = false
            mapButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let food = sender as? Foods
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.food = food
        }
    }
}

extension HomeViewController : PresenterToViewHomeProtocol {
    func sendDataToView(foodList: Array<Foods>) {
        self.foodsList = foodList
        self.filteredFoodsList = foodList
            self.foodsCollectionView?.reloadData()
    }
    
}
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.foodsCollectionView {
            return filteredFoodsList.count
           }
        else{
            return categories.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodsCollectionView {
            let food = filteredFoodsList[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodsCollectionView", for: indexPath) as! HomeCollectionViewCell
            cell.foodName.text = "\(food.yemek_adi!)"
            cell.foodPrice.text = "\(food.yemek_fiyat!) ₺"
            let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)")
            cell.foodImageView.kf.setImage(with: url)
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.3
            cell.layer.cornerRadius = 10.0
               // Set up cell
            return cell
            
        }else{
            let category = categories[indexPath.row]
            
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
            categoryCell.categoryName.text = "\(category.category_name!)"
            categoryCell.categoryImage.image = UIImage(named: "\(category.category_image!)")
            
            return categoryCell
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.foodsCollectionView {
        let food = filteredFoodsList[indexPath.row]
      performSegue(withIdentifier: "toDetail", sender: food)
        }
        
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredFoodsList = self.foodsList.filter{food in
            if food.yemek_adi!.lowercased().contains(searchText.lowercased()){
                warningView?.isHidden = false
                return true
            }
            if searchText == ""{
                warningView?.isHidden = true
                return true
            }
            return false
        }
        self.foodsCollectionView.reloadData()
    }
}

