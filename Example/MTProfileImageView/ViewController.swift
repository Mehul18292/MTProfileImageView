//
//  ViewController.swift
//  MTProfileImageView
//
//  Created by Mehul Thakkar on 02/14/2019.
//  Copyright (c) 2019 Mehul Thakkar. All rights reserved.
//

import UIKit
import MTProfileImageView

class ViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: MTProfileImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profileImageView.firstName = "Aklesh"
        profileImageView.lastName = "Rathaur"
        profileImageView.profileImageURLStr = nil;
        profileImageView.fullName = "Aklesh Rathaur";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

