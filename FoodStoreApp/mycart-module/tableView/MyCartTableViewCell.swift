//
//  MyCartTableViewCell.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 26.05.2022.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet weak var cellFoodName: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
 
    @IBOutlet weak var cellFoodNumber: UILabel!
    @IBOutlet weak var cellFoodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
