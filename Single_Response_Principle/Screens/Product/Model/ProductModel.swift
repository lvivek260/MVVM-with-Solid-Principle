//
//  ProductModel.swift
//  MVVM_Loading_Internet_Demo
//
//  Created by PHN MAC 1 on 03/06/23.
//


import Foundation

struct ProductModel: Decodable{
    let products: [Product]
}

struct Product: Decodable{
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}
