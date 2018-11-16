//
//  ShoppingViewController.swift
//  ClickNBuy
//
//  Created by Isaac Kim on 16/11/2018.
//  Copyright © 2018 Isaac Kim. All rights reserved.
//

import UIKit

import Alamofire



class ShoppingViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var minimumPriceSearch: UISearchBar!
    var minimumPriceText = String()
  
    // first item
    @IBOutlet weak var textLabelForBold: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    // second item
    @IBOutlet weak var secondImageLabel: UIImageView!
    @IBOutlet weak var secondProductLabel: UILabel!
    @IBOutlet weak var secondPriceLabel: UILabel!
    
    // third item
    @IBOutlet weak var thirdImageLabel: UIImageView!
    @IBOutlet weak var thirdProdcutLabel: UILabel!
    @IBOutlet weak var thirdPriceLabel: UILabel!
    
    
    // fourth item
    @IBOutlet weak var fourthImageLabel: UIImageView!
    @IBOutlet weak var fourthProductLabel: UILabel!
    @IBOutlet weak var fourthPriceLabel: UILabel!
    
    
    // fifth item
    @IBOutlet weak var fifthImageLabel: UIImageView!
    @IBOutlet weak var fifthProductLabel: UILabel!
    @IBOutlet weak var fifthPriceLabel: UILabel!
    
    
    // sixth item
    @IBOutlet weak var sixthImageLabel: UIImageView!
    @IBOutlet weak var sixthProductLabel: UILabel!
    @IBOutlet weak var sixthPriceLabel: UILabel!
    
    
    // seventh item
    
    // eighth item
    
    // nineth item
    
    // tenth item
    
    
    
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
            
            guard let imageUrl = URL(string: shoppingList.items[0].image) else { return }
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(data: data)
                    print("Image loaded")
                }
            }
            
            guard let imageUrl2 = URL(string: shoppingList.items[1].image) else { return }
            if let data = try? Data(contentsOf: imageUrl2) {
                DispatchQueue.main.async {
                    self.secondImageLabel.image = UIImage(data: data)
                    print("Image loaded")
                }
            }
            
            guard let imageUrl3 = URL(string: shoppingList.items[2].image) else { return }
            if let data = try? Data(contentsOf: imageUrl3) {
                DispatchQueue.main.async {
                    self.thirdImageLabel.image = UIImage(data: data)
                    print("Image loaded")
                }
            }
            
            guard let imageUrl4 = URL(string: shoppingList.items[3].image) else { return }
            if let data = try? Data(contentsOf: imageUrl4) {
                DispatchQueue.main.async {
                    self.fourthImageLabel.image = UIImage(data: data)
                    print("Image loaded")
                }
            }
            
            guard let imageUrl5 = URL(string: shoppingList.items[4].image) else { return }
            if let data = try? Data(contentsOf: imageUrl5) {
                DispatchQueue.main.async {
                    self.fifthImageLabel.image = UIImage(data: data)
                    print("Image loaded")
                }
            }
            
            guard let imageUrl6 = URL(string: shoppingList.items[5].image) else { return }
            if let data = try? Data(contentsOf: imageUrl6) {
                DispatchQueue.main.async {
                    self.sixthImageLabel.image = UIImage(data: data)
                    print("Image loaded")
                }
            }
            
            
            DispatchQueue.main.async {
                
                // first item label
                self.textLabelForBold.text = shoppingList.items[0].title
                self.priceLabel.text = "Price: ₩ \(shoppingList.items[0].lprice)"
                
                // second item label
                self.secondProductLabel.text = shoppingList.items[1].title
                self.secondPriceLabel.text = "Price: ₩ \(shoppingList.items[1].lprice)"
                
                // third item label
                self.thirdProdcutLabel.text = shoppingList.items[2].title
                self.thirdPriceLabel.text = "Price: ₩ \(shoppingList.items[2].lprice)"
                
                // fourth item label
                self.fourthProductLabel.text = shoppingList.items[3].title
                self.fourthPriceLabel.text = "Price: ₩ \(shoppingList.items[3].lprice)"
                
                // fifth item label
                self.fifthProductLabel.text = shoppingList.items[4].title
                self.fifthPriceLabel.text = "Price: ₩ \(shoppingList.items[4].lprice)"
                
                // sixth item label
                self.sixthProductLabel.text = shoppingList.items[5].title
                self.sixthPriceLabel.text = "Price: ₩ \(shoppingList.items[5].lprice)"
                
                
                
            }
//
//            let url = URL(string: "https://loremflickr.com/860/640/cat")!
//            if let data = try? Data(contentsOf: url) {
//                print("image downloaded")
//                imageView.image = UIImage(data: data)
            
            
            
//            for i in 0...(shoppingList.items.count - 1) {
//                print("title: ", shoppingList.items[i].title)
//                print("Lowest Price: " , shoppingList.items[i].lprice)
//                print("Buy Link: ", shoppingList.items[i].link)
//                print("image Link: ", shoppingList.items[i].image)
//
//
//            }
    })
        task.resume()
      
    }
    


}
