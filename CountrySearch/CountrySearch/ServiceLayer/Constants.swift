//
//  Constants.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 17/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit

struct APIURLParameters {
    struct ProductionServer {
        
        static let baseURL = "https://restcountries.eu/rest/v2"
        //"http://itechnodev.com/api"
    }
    struct StagingServer {
        static let baseURL = "https://restcountries.eu/rest/v2"
    }
    
    struct APIParameterKey {
        static let name = "name"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
