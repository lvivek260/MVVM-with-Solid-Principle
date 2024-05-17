//
//  ImageView+Extension.swift
//  MVVM_Loading_Internet_Demo
//
//  Created by PHN MAC 1 on 03/06/23.
//

import UIKit
import Kingfisher

//extension UIImageView{
//    func setImage(urlString:String){
//        guard let imageUrl = URL(string: urlString) else{
//            return
//        }
//        let resource = ImageResource(name: imageUrl,bundle: urlString)
//        kf.indicatorType = .activity
//        kf.setImage(with:resource)
//    }
//}

extension UIImageView {
    func setImage(urlString: String) {
        let placeholder: UIImage? = nil     // if you want to add placeholder image like dymmy image
        if let url = URL(string: urlString) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: placeholder)
        } else {
            // Handle invalid URL or display a placeholder/error image
            self.image = placeholder
        }
    }
}
