//
//  ItemCell.swift
//  ClickNBuy
//
//  Created by Isaac Kim on 19/11/2018.
//  Copyright © 2018 Isaac Kim. All rights reserved.
//

import UIKit

final class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var minimumPriceLabel: UILabel!
    
    static let identifier: String = "ItemCell"
    
    var productName: String?
    var minimumPrice: String?
    
    func setupCell(productName: String, imageName: String, minimumPrice: String) {
        productNameLabel.text = productName
        minimumPriceLabel.text = minimumPrice
        guard let imageUrl = URL(string: imageName) else { return }
        if let data = try? Data(contentsOf: imageUrl)
        {
            itemImageView.image = UIImage(data: data)
            
            
        }
        
    }
    
    
}
