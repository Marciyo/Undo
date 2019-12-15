//
//  TripDetailsViewModel.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import Foundation

class TripDetailsViewModel {
    private let trip: Trip

    lazy var coInsured: [String] = {
        trip.coInsured.map { $0.firstNames }
    }()

    lazy var coverages: [String] = {
        let keys = trip.coverages.map { $0.titleLocalizationKey }
        return keys.compactMap { $0.uppercased() }
    }()

    lazy var countryName: String = {
        "Spanien1"
    }()

    lazy var pricePerDay: String = {
        "17 kr/day"
    }()

    lazy var totalPrice: String = {
        "\(trip.currentTotalPrice / 100)"
    }()

    lazy var duration: String = {
        "17 days"
    }()

    init(trip: Trip) {
        self.trip = trip
    }
}
