//
//  APIRouter.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 17/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case allCountry
    case country(name: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .allCountry, .country:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .allCountry:
            return "/all"
        case .country(let nameOfCountry):
            return "/name/\(nameOfCountry)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .allCountry:
            return nil
        case .country(let nameOfCountry):
            return [APIURLParameters.APIParameterKey.name: nameOfCountry]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try APIURLParameters.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
