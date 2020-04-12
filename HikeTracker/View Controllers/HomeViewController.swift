//
//  HomeViewController.swift
//  HikeTracker
//
//  Created by Sam Hoidal on 2/28/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var newHikeButton: UIButton!
    @IBOutlet weak var pastHikesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newHikeButton.layer.cornerRadius = 15
        newHikeButton.layer.borderWidth = 1
        newHikeButton.layer.borderColor = UIColor(displayP3Red: 229.0/255.0, green: 228.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        pastHikesButton.layer.cornerRadius = 15
        pastHikesButton.layer.borderWidth = 1
        pastHikesButton.layer.borderColor = UIColor(displayP3Red: 229.0/255.0, green: 228.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        
    }
}
