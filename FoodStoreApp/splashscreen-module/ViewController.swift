//
//  ViewController.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 24.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let todoGif = UIImage.gifImageWithName("foodstore")
        imageView?.image = todoGif
        let timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }

    @objc func timeToMoveOn() {
            self.performSegue(withIdentifier: "toLoading", sender: self)
        }
}

