//
//  MyCell.swift
//  WeatherVF
//
//  Created by Victor Fundberg on 2018-03-28.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    var city : String?
    var temp : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
