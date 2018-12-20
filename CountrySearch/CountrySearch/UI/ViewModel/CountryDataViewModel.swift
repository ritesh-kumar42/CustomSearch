//
//  CountryDataViewModel.swift
//  Countries
//
//  Created by Ritesh Kumar on 20/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PocketSVG

class CountryDataViewModel: NSObject{
    
    /// mapCountryDataToModel
    ///
    /// - Parameter model: Json model
    /// - Returns: Database model
    static func mapCountryDataToModel(model:CountryModelElement?)-> CountryDBModel{
        let dataModel = CountryDBModel()
        dataModel.name = model?.name ?? ""
        dataModel.capital = model?.capital ?? ""
        dataModel.callingCode = model?.callingCodes?.joined(separator: " ") ?? ""
        dataModel.timeZone = model?.timezones?.joined(separator: " ") ?? ""
        dataModel.subRegion = model?.subregion ?? ""
        dataModel.region = model?.region?.rawValue ?? ""
        dataModel.flag = model?.flag ?? ""
        
        var currencyString = ""
        for cur:Currency in model?.currencies ?? [Currency(code: "", name: "", symbol: "")]{
            currencyString = (cur.name)! + " " + currencyString
        }
        dataModel.currencies = currencyString
        
        var languageString = ""
        for langua:Language in model?.languages ?? [Language(iso6391: "", iso6392: "", name: "", nativeName: "")]{
            languageString = languageString + " " + (langua.name)!
        }
        dataModel.languages = languageString
        
        return dataModel
    }
    
    /// showSVGImage
    ///
    /// - Parameters:
    ///   - imageURL: image path
    ///   - rect: render rect
    /// - Returns: View
    static func showSVGImage(imageURL:URL, rect:CGRect)->UIView{
        let svgImageView = SVGImageView.init(contentsOf: imageURL)
        svgImageView.frame = rect
        svgImageView.contentMode = .scaleAspectFit
        return svgImageView
    }
    
    /// getSaveFileUrl
    ///
    /// - Parameter fileName: file name
    /// - Returns: URL of image
    static func getSaveFileUrl(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        NSLog(fileURL.absoluteString)
        return fileURL;
    }
    
    /// loadSVGImage
    ///
    /// - Parameters:
    ///   - svgImage: name of image
    ///   - rect: rect
    ///   - completion: UIView
    static func loadSVGImage(svgImage: String, rect: CGRect, completion:@escaping(UIView)->Void){
        let svgImagePath = CountryDataViewModel.getSaveFileUrl(fileName: svgImage)
        if FileManager.default.fileExists(atPath: svgImagePath.absoluteString){
            let svgImageView = CountryDataViewModel.showSVGImage(imageURL: svgImagePath, rect: rect)
            completion(svgImageView)
        }
        else{
            downloadSVGImage(svgImage: svgImage) { (svgURL) in
                let svgImageView = CountryDataViewModel.showSVGImage(imageURL: svgURL, rect: rect)
                completion(svgImageView)
            }
        }
    }
    
    
    /// downloadSVGImage
    ///
    /// - Parameters:
    ///   - svgImage: image name
    ///   - completion: URL for image
    static func downloadSVGImage(svgImage: String, completion:@escaping (URL)->Void) -> Void{
        let fileUrl = CountryDataViewModel.getSaveFileUrl(fileName: svgImage)
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(svgImage, to:destination)
            .downloadProgress { (progress) in
            }
            .responseData { (data) in
                completion(fileUrl)
        }
    }
    
}
