//
//  CountryListCell.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 16/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIView!
    @IBOutlet weak var countryName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
