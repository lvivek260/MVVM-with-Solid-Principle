//
//  ProductDetailViewController.swift
//  MultipleApiFetch
//
//  Created by Admin on 10/03/23.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var realProductPrice: UILabel!
    @IBOutlet weak var datailView: UIView!
    @IBOutlet weak var categary: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productOffPercentage: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productPage: UIPageControl!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    var obj:Product?
    var images:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfiguration()
        setData()
    }
    
    func collectionViewConfiguration(){
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        productImagesCollectionView.register(ProductDetailCollectionViewCell.nib, forCellWithReuseIdentifier: ProductDetailCollectionViewCell.id)
    }
    func setData(){
        guard let obj else{return}
        let discountInRs = Float(obj.discountPercentage/100)*Float(obj.price)
        let sellingPrice:Float = Float(obj.price) - discountInRs
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "₹" + String(obj.price))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        
        //Binding Data
        images = obj.images
        productPage.currentPage = 0
        productPage.numberOfPages = images.count
        productTitle.text = obj.title
        productRating.text = "  \(String(describing: obj.rating))★ "
        productRating?.layer.cornerRadius = 10.0
        productPrice.text = "₹" + String(Int(sellingPrice))
        productOffPercentage.text = String(Int(obj.discountPercentage)) + "% off"
        priceView.layer.cornerRadius = 30
        datailView.layer.cornerRadius = 30
        categary.text = obj.category
        brand.text = obj.brand
        id.text = String(obj.id)
        realProductPrice.attributedText = attributeString
    }
}
extension ProductDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.id, for: indexPath) as? ProductDetailCollectionViewCell else{
            fatalError("xib not present")
        }
        cell.allProductImage.setImage(urlString: images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        productPage.currentPage = indexPath.row
    }
}

extension ProductDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
 
