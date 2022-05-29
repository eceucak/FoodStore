//
//  LoadingViewController.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 28.05.2022.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let loading = UIImage.gifImageWithName("loading")
        loadingGif?.image = loading
        let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc func timeToMoveOn() {
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    
