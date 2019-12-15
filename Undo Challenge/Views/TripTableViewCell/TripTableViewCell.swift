//
//  TripTableViewCell.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 14/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with data: TripCellData) {
        countryLabel.text = data.country
        datesLabel.text = data.dates
        priceLabel.text = data.price
        durationLabel.text = data.duration
    }
}

extension TripTableViewCell: NibReusableView { }


