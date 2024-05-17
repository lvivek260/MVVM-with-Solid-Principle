//
//  EndPointItems.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 05/10/23.
//

import Foundation

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

protocol EndPointType{
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
    var httpMethod: HttpMethod { get }
    var parameter: Data? { get }
    var header: [String: String]? { get }
}

enum endPointItems{
    case getProduct
}

extension endPointItems: EndPointType{
    var baseURL: String {
        return "https://dummyjson.com/"
    }
    
    var path: String {
        switch self{
        case .getProduct:
            return "products"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL+path)
    }
    
    var httpMethod: HttpMethod {
        switch self{
        case .getProduct:
            return .get
        }
    }
    
    var parameter: Data? {
        switch self{
        case .getProduct:
            return nil
        }
    }
    
    var header: [String : String]? {
        return nil
    }
}
