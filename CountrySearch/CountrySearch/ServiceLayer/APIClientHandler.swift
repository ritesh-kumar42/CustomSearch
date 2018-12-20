//
//  APIClientHandler.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 17/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
class APIClientHandler: NSObject {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
    static func fetchAllCountry(completion:@escaping (Result<CountryModel>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.allCountry, decoder: jsonDecoder, completion: completion)
    }
    static func fetchAllCountriesBasedOn(nameOfCountry:String, completion:@escaping (Result<CountryModel>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.country(name: nameOfCountry), decoder: jsonDecoder, completion: completion)
    }

}
