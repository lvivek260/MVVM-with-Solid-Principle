//
//  MainModule.swift
//  MVVM_Loading_Internet_Demo
//
//  Created by PHN MAC 1 on 03/06/23.
//

import UIKit

enum STORYBOARD: String{
    case MAIN = "Main"
}
struct MainModule{
    static func getStoryboard(type: STORYBOARD) -> UIStoryboard {
        return UIStoryboard(name: type.rawValue, bundle: Bundle.main)
    }
    
    static func getProductDetailVC()->ProductDetailViewController{
        guard let viewController = getStoryboard(type: .MAIN).instantiateViewController(withIdentifier: String(describing: ProductDetailViewController.self)) as? ProductDetailViewController else {return ProductDetailViewController()}
        return viewController
    }
}
