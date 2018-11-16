//
//  ViewController.swift
//  HackathonPractice
//
//  Created by Bernard Hur on 16/11/2018.
//  Copyright © 2018 Bernard Hur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let astronauts = "http://api.open-notify.org/astros.json"
        let apiURL = URL(string: astronauts)!
        
        let dataTask = URLSession.shared.dataTask(with: apiURL) 
        
    }


    
    
    
}

