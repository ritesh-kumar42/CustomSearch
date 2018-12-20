//
//  CountryListViewModel.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 17/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit

typealias CompletionHandler = ([CountryModelElement]?) -> Void

class CountryListViewModel: NSObject {

    var listOfCountries = [Any]()
    
    /// callCountryData
    ///
    /// - Parameter completion: get lsit of countries
    func callCountryData(completion:@escaping CompletionHandler){
        // Fetch All Country Data
        if Connectivity.isConnectedToInternet() {
            APIClientHandler.fetchAllCountry { result in
                switch result {
                case .success(let countries):
                    print("_____________________________")
                    print(countries)
                    completion(countries)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([])
                }
            }
        }
        else{
            // Database calls to fetch saved countries
        }
    }
    
    /// fetchCountryData
    ///
    /// - Parameters:
    ///   - nameOfCountry: name of country
    ///   - completion: get the list of countries
    func fetchCountryData(nameOfCountry:String, completion:@escaping CompletionHandler){
        // Fetch All Country Data
        if Connectivity.isConnectedToInternet() {
            APIClientHandler.fetchAllCountriesBasedOn(nameOfCountry: nameOfCountry) { result in
                switch result {
                case .success(let countries):
                    print("_____________________________")
                    print(countries)
                    completion(countries)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([])
                }
            }
        }
        else{
            // Database calls to fetch saved countries
        }
    }
}
