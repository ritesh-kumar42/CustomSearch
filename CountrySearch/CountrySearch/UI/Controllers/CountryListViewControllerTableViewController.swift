//
//  CountryListViewControllerTableViewController.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 14/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

let COUNTYCELL = "COUNTYCELL"

struct Country:Codable{
    let name:String
    let flag:String
    let flagePath:String
}
class CountryListViewControllerTableViewController: UITableViewController, UISearchResultsUpdating {

    var svgURL = URL(string: "https://openclipart.org/download/181651/manhammock.svg")
    
    var listOfCountry = [Results<CountryDBModel>]()
    var filteredCountry:CountryModel? = []
    var filteredSavedCountry = [Results<CountryDBModel>]()
    
    var searchController = UISearchController()
    var searchResultTableView = UITableViewController()
    weak var timer: Timer?
    var realm: Realm!
    
    var countryViewModel = CountryListViewModel()
    
    /// View Did Load method
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromDB()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reusableCell")
        self.tableView.register(CountryListCell.self, forCellReuseIdentifier: "reusableCountryList")
//        countryViewModel.callCountryData()
        setupSearchReesultViewController()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    
    /// View Will appear method
    ///
    /// - Parameter animated: YES/NO
    override func viewWillAppear(_ animated: Bool) {
        fetchDataFromDB()
    }
    
    /// get data from database
    func fetchDataFromDB(){
        realm = try! Realm()
        self.listOfCountry = [realm.objects(CountryDBModel.self)]
        print(listOfCountry)
    }
    
    /// Setup search bar
    func setupSearchReesultViewController(){
        self.searchController = UISearchController(searchResultsController: self.searchResultTableView)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchResultTableView.tableView.dataSource = self
        self.searchResultTableView.tableView.delegate = self
    }
}

extension CountryListViewControllerTableViewController{
    // MARK: - Search Result delegate
    
    /// update the search result based on the typed value
    ///
    /// - Parameter searchController: searchController
    func updateSearchResults(for searchController: UISearchController) {
        // cancel prior timer, if any
        timer?.invalidate()
        
        timer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            if Connectivity.isConnectedToInternet(){
                self?.countryViewModel.fetchCountryData(nameOfCountry: self?.searchController.searchBar.text ?? "", completion: { (countries) in
                    self?.filteredCountry = countries ?? nil
                    self?.searchResultTableView.tableView.reloadData()
                    self?.tableView.reloadData()
                    timer.invalidate()
                }) ?? nil
            }
            else{
                let unsortedObjects = self?.realm.objects(CountryDBModel.self).filter("name BEGINSWITH '\(self?.searchController.searchBar.text ?? "")'")
                self?.filteredSavedCountry.removeAll()
                self?.filteredSavedCountry.append(unsortedObjects!)
                self?.searchResultTableView.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    /// No Od Section
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - section: section
    /// - Returns: integer value
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return listOfCountry[section].count
        }
        else {
            if Connectivity.isConnectedToInternet(){
                return filteredCountry?.count ?? 0
            }
        }
        if filteredSavedCountry.count > 0{
            return filteredSavedCountry[section].count
        }
        return 0
    }
    
    
    /// Cell for row at index path
    ///
    /// - Parameters:
    ///   - tableView: tableview
    ///   - indexPath: indexPath
    /// - Returns: cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        if tableView == self.tableView{
            let countryObject = objectForIndexPath(indexPath: indexPath)
            cell.textLabel?.text = countryObject?.name
            
//            CountryDataViewModel.loadSVGImage(svgImage: countryObject?.flag ?? "", rect: CGRect(x: cell.bounds.width - 64, y: 0, width: 64, height: cell.bounds.height)) { (view) in
//                cell.contentView.addSubview(view)
//            }
        }
        else{
            if Connectivity.isConnectedToInternet(){
                cell.textLabel?.text = filteredCountry?[indexPath.row].name
            }
            else{
                let countryObject = objectForIndexPathFromBD(indexPath: indexPath)
                cell.textLabel?.text = countryObject?.name ?? ""
            }
        }
        return cell
    }
    
    /// Selection of cell
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - indexPath: indexPath
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect the table cell
        self.tableView.deselectRow(at: indexPath , animated: true)
        // cancle thee search event
        self.searchController.isActive = false
        // Navigate to the detail screen with data
        let detailViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryDetail") as? CountryDetailViewController
        var countryName = ""
        if tableView == self.tableView{
            let countryObject = objectForIndexPath(indexPath: indexPath)
            detailViewController?.selectedCountryDBModel = countryObject
            countryName = countryObject?.name ?? ""
        }
        else{
            if Connectivity.isConnectedToInternet(){
                detailViewController?.selectedCountry = filteredCountry?[indexPath.row]
                countryName = filteredCountry?[indexPath.row].name ?? ""
            }
            else{
                let countryObject = objectForIndexPathFromBD(indexPath: indexPath)
                detailViewController?.selectedCountryDBModel = countryObject
                countryName = countryObject?.name ?? ""
            }
        }
        
        detailViewController?.navigationItem.title = countryName
        self.navigationController?.pushViewController(detailViewController!, animated: true)
        
    }
    
    /// Get the Country Object based on index
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: CountryDBModel
    func objectForIndexPath(indexPath: IndexPath) -> CountryDBModel? {
        return listOfCountry[indexPath.section][indexPath.row]
    }
    func objectForIndexPathFromBD(indexPath: IndexPath) -> CountryDBModel? {
        if filteredSavedCountry.count > 0{
            return filteredSavedCountry[indexPath.section][indexPath.row]
        }
        return CountryDBModel()
    }
    
}



//let savedCell:CountryListCell = self.tableView.dequeueReusableCell(withIdentifier: "reusableCountryList", for: indexPath) as! CountryListCell
//
//
//let countryObject = objectForIndexPath(indexPath: indexPath)
//savedCell.countryName?.text? = "Test"//countryObject?.name
//
//CountryDataViewModel.loadSVGImage(svgImage: countryObject?.flag ?? "", rect: savedCell.cellImageView?.bounds ?? CGRect.zero) { (view) in
//    savedCell.cellImageView?.addSubview(view)
//}
//return savedCell
