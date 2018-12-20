//
//  CountryModel.swift
//  Countries
//
//  Created by Ritesh Kumar on 20/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CountryDBModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var flag = ""
    @objc dynamic var capital = ""
    @objc dynamic var callingCode = ""
    @objc dynamic var region = ""
    @objc dynamic var subRegion = ""
    @objc dynamic var timeZone = ""
    @objc dynamic var currencies = ""
    @objc dynamic var languages = ""
}
