//
//  ShoppingViewController.swift
//  ClickNBuy
//
//  Created by Isaac Kim on 16/11/2018.
//  Copyright © 2018 Isaac Kim. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var minimumPriceSearch: UISearchBar!
    var minimumPriceText = String()
    var shoppingArray: Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minimumPriceSearch.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.minimumPriceText = searchBar.text ?? ""
        fetchNaverAPI(query: minimumPriceText)
        print("searchBar input: ", minimumPriceText)
    }
    
    private func fetchNaverAPI(query: String) {
        
        guard let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(query)") else { return }
        var request = URLRequest(url: url)
        request.setValue("gXNHEbsr4g8csfZTGZCC", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("257bAm0OmZ", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            let shoppingList = try! JSONDecoder().decode(ShoppingList.self, from: data)
            self.shoppingArray = shoppingList.items
            print("self.shoppingArray :", self.shoppingArray)
            print("shoppingArray[0]", self.shoppingArray[0])
            print("shoppingArray[1]", self.shoppingArray[1])
        })
        task.resume()
        print("shoppingArray at fachNaverAPI: ", shoppingArray)
    }
//    print("shoppingArrat at VC :", shoppingArray)
}
