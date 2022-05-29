//
//  HomeCollectionViewCell.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        favouriteButton.tintColor = UIColor.systemOrange
    }
    
    
}
