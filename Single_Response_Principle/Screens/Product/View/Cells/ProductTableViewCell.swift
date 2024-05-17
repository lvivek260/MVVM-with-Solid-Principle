//
//  ProductTableViewCell.swift
//  MultipleApiFetch
//
//  Created by Admin on 10/03/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productOffPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productOffPercantage: UILabel!
    
    var product: Product?{
        didSet{
            guard let product else{return}
            
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: String(product.price))
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            let discountInRs = Float(product.discountPercentage/100)*Float(product.price)
            let sellingPrice:Float = Float(product.price) - discountInRs
            
            //Binding Data
            productPrice.attributedText = attributeString
            productTitle.text = product.title
            productOffPrice.text = "₹"+String(Int(sellingPrice))
            productPrice.text = "₹"+String(product.price)
            productRating.text = "Rating "+String(product.rating)
            productOffPercantage.text = String(Int(product.discountPercentage)) + "% Off"
            productOffPercantage.textColor = .green
            productImage.setImage(urlString: product.thumbnail)
        }
    }
}
