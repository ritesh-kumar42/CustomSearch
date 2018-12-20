//
//  CountryDetailViewController.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 18/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit
import Alamofire
import PocketSVG
import RealmSwift


class CountryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var downloadProgress: UIActivityIndicatorView!
    @IBOutlet weak var countryFlagImage: UIView!
    @IBOutlet weak var countryNameAndCapital: UILabel!
    @IBOutlet weak var detailTable: UITableView!
    
    var selectedCountry:CountryModelElement? = nil
    var selectedCountryDBModel:CountryDBModel? = nil
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.selectedCountry != nil) {
            self.selectedCountryDBModel = CountryDataViewModel.mapCountryDataToModel(model: self.selectedCountry)
            addSaveButton()
        }
        
        
        
        let firstName = selectedCountryDBModel?.name ?? ""
        let capital = selectedCountryDBModel?.capital ?? ""
        countryNameAndCapital.text = firstName + "(" + capital + ")"
        
        CountryDataViewModel.loadSVGImage(svgImage: selectedCountryDBModel?.flag ?? "", rect: self.countryFlagImage.bounds) { (view) in
            self.countryFlagImage?.addSubview(view)
        }
    }
    
    /// addSaveButton
    func addSaveButton(){
        let rightButtonItem = UIBarButtonItem.init(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(rightButtonAction)
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    /// rightButtonAction
    @objc func rightButtonAction(){
        let realm = try? Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        guard let country = selectedCountryDBModel else {
            return
        }
        try! realm?.write{
            realm?.add(country)
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    /// viewDidAppear
    ///
    /// - Parameter animated: YES or No
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
}

extension CountryDetailViewController{
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    /// cell for index path
    ///
    /// - Parameters:
    ///   - tableView: table view
    ///   - indexPath: indexpath
    /// - Returns: cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell_CallingCode", for: indexPath)
            cell.textLabel?.text = selectedCountryDBModel?.callingCode
        }
        else if indexPath.row == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ Region", for: indexPath)
            cell.textLabel?.text = selectedCountryDBModel?.region
        }
        else if indexPath.row == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell_SubRegion", for: indexPath)
            cell.textLabel?.text = selectedCountryDBModel?.subRegion
        }
        else if indexPath.row == 3{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell_TimeZone", for: indexPath)
            cell.textLabel?.text = selectedCountryDBModel?.timeZone
        }
        else if indexPath.row == 4{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ Currencies", for: indexPath)
            cell.textLabel?.text = selectedCountryDBModel?.currencies
        }
        else if indexPath.row == 5{
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ Languages", for: indexPath)
            cell.textLabel?.text = selectedCountryDBModel?.languages
        }
        
        return cell
    }
}
