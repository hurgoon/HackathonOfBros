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
    @IBOutlet weak var textLabelForBold: UILabel!
    
    
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
            
            var titleArray:[String] = []

            titleArray = [shoppingList.items[0].title]
            DispatchQueue.main.async {
                self.textLabelForBold.text = titleArray[0]
            }
            
            for i in 0...(shoppingList.items.count - 1) {
                print(shoppingList.items[i].title)
                print(shoppingList.items[i].lprice)
                print(shoppingList.items[i].link)
                print(shoppingList.items[i].image)
                
                
            }
    })
        task.resume()
      
    }

}
