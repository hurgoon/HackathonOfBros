//
//  CollectionViewController.swift
//  ClickNBuy
//
//  Created by Isaac Kim on 17/11/2018.
//  Copyright © 2018 Isaac Kim. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchForShopping: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var productName: [ String ] = []
    var lowestPrice: [String] = []
    var image: [ String ] = []
    
    
    
    var purchasedLink : [String] = []
    var mallName : [ String ] = []
    
    var searchText = String()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchForShopping.delegate = self
       
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text ?? ""
        naverAPIFectch(query: searchText)
        searchBar.resignFirstResponder()
        tableView.reloadData()
        
        
        
    }
    
    
    private func naverAPIFectch(query: String) {
        
        guard let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(query)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("gXNHEbsr4g8csfZTGZCC", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("257bAm0OmZ", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            
            let shoppingList = try! JSONDecoder().decode(ShoppingList.self, from: data)
            
            DispatchQueue.main.async {
            
            
            
                for i in 0...(shoppingList.items.count - 1) {
//                    self.productName = [shoppingList.items[i].title]
                    self.productName.append(shoppingList.items[i].title)
                    self.lowestPrice.append(shoppingList.items[i].lprice)
                    self.purchasedLink.append(shoppingList.items[i].link)
                    self.mallName.append(shoppingList.items[i].mallName)
                    self.image.append(shoppingList.items[i].image)
                    
                 
                    
                }
                
                
              
            }
        
        }
        task.resume()
        
        
    }
    
    @IBAction func checkDataWhetherDataHasBeenSaved(_ sender: UIButton) {
        
        print(self.productName)
        print(lowestPrice)
        print(purchasedLink)
        print("mallName: ", mallName)
        
        
    }
    
    
}

extension CollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productName.count > 0 {
            return productName.count
        } else {
            return 1

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        
        if productName.count > 0 {
        cell.setupCell(productName: productName[indexPath.row], imageName:image[indexPath.row] , minimumPrice: lowestPrice[indexPath.row])
        } else {
            return cell
        }
        
        
        return cell
    }
    
    
    
}

