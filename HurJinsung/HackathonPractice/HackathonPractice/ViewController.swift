//
//  ViewController.swift
//  HackathonPractice
//
//  Created by Bernard Hur on 16/11/2018.
//  Copyright © 2018 Bernard Hur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let astronauts = "http://api.open-notify.org/astros.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let astro = astronaouts()
        
        
        
    }
    
    func astronaouts () {
        
        let apiURL = URL(string: astronauts)!
        
        let dataTask = URLSession.shared.dataTask(with: apiURL) {
            (data, response, error) in
            guard let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
                else { return print("no data")}
            print("jsonObject :", jsonObject)
            
            guard(jsonObject["message"] as? String) == "success",
                let people = jsonObject["people"] as? [[String:String]],
                let peopleCount = jsonObject["number"] as? Int
                else { return print("parcing fail")}
            
            print("---parsing Success---")
            print("\(peopleCount) members is on Universe")
            
            print("members information")
            people
                .compactMap{ $0["name"]}
                .forEach { print($0)}
        }
        
        dataTask.resume()
        
    }
    
    
    
    
    
    
    
}

