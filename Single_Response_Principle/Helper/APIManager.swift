//
//  APIManager.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 05/10/23.
//

import Foundation

enum FetchingError: Error{
    case invalidUrl
    case invalidData
    case invalidResponse
    case DecodingError(Error)
}

typealias ResultHandler<T> = (Result<T, FetchingError>) -> Void

//high-level class
final class APIManager{
    
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    init(networkHandler: NetworkHandler,
         responseHandler: ResponseHandler) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: endPointItems,
        completion: @escaping ResultHandler<T>
    ){
        guard let url = type.url else{
            completion(.failure(.invalidUrl))
            return
        }
        
        //create request
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        if let body = type.parameter{
            request.httpBody = body
            request.allHTTPHeaderFields = type.header
        }
        
        networkHandler.requestDataAPI(url: request) { result in
            switch result{
            case .success(let data):
                //convert data
                self.responseHandler.parseResonseDecode(data: data,modelType: modelType) { result in
                    switch result{
                    case .success(let fetchingData):
                        completion(.success(fetchingData))
                        break
                    case .failure(let error):
                        completion(.failure(.DecodingError(error)))
                        break
                    }
                }
                break
                
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
    }
}

//low-level class
class NetworkHandler {

    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, FetchingError>) -> Void
    ) {
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(data))
        }
        session.resume()
    }

}

//low-level class
class ResponseHandler {

    func parseResonseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: ResultHandler<T>
    ) {
        do {
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            completionHandler(.success(userResponse))
        }catch let error{
            completionHandler(.failure(.DecodingError(error)))
        }
    }

}

