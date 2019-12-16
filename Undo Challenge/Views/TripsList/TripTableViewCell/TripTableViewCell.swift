//
//  TripTableViewCell.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 14/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

final class TripTableViewCell: UITableViewCell {

    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var datesLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

    func configure(with data: TripCellData) {
        countryLabel.text = data.country
        datesLabel.text = data.dates
        priceLabel.text = data.price
        durationLabel.text = data.duration
    }
}

extension TripTableViewCell: NibReusableView { }
