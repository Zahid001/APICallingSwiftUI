//
//  Router.swift
//  CountriesList
//
//  Created by Macbook on 03/03/2022.
//

import Foundation

typealias HTTPParameters = [String: Any]?

enum Router {
    
   
    case repositories(String,String)
    
    // MARK: - HTTP Method
    var method: HTTPMethod {
        switch self {
        case  .repositories:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .repositories:
            return "repositories"
        }
    }
    
    // MARK: - Parameters
    var parameters: HTTPParameters {
        switch self {
        case .repositories(let query, let page):
            return [
                "q": query,
                "page": page,
            ]
        default:
            return nil
        }
    }
    
    var url: URL {
        guard let url = URL(string: kNetworkEnvironment.baseURL + "/search/") else {
            fatalError(ErrorMessage.invalidUrl.rawValue)
        }
        return url
    }
    
    // MARK: - URLRequestConvertible
    func requestURL() throws -> URLRequest {
        
        var components = URLComponents(string: url.appendingPathComponent(path).description)!
        components.queryItems = []
        
        if let param = parameters {
            components.queryItems = param.map { (key, value) in
                URLQueryItem(name: key, value: value as? String)
            }
            
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: components.url!)
        
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = kRequestCachePolicy
        urlRequest.timeoutInterval = kTimeoutInterval
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        return urlRequest
    }
}
