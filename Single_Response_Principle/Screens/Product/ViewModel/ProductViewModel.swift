//
//  ProductViewModel.swift
//  MVVM_Loading_Internet_Demo
//
//  Created by PHN MAC 1 on 03/06/23.
//

import Foundation

final class ProductViewModel{
    
    let apiManager: APIManager
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    var products: [Product] = []
    var eventHandler : ((_ event: Event) -> Void)?
    
    func fetchProduct(){
        DispatchQueue.main.async {
            self.eventHandler?(.startLoading)
        }
        apiManager.request(modelType: ProductModel.self, type: .getProduct)
        { result in
            self.eventHandler?(.stopLoading)
            switch result{
            case .success(let products):
                self.products = products.products
                self.eventHandler?(.reloadData)
                break
                
            case .failure(let error):
                self.eventHandler?(.error(error))
                break
            }
        }
    }
}
