//
//  TripDetailsViewModel.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import Foundation

final class TripDetailsViewModel {

    let coInsured: [String]
    var coverages: [String]
    let countryName: String
    let firstCoverage: String?
    let totalPrice: String
    let duration: String
    let pricePerDay: String

    init(trip: Trip) {
        let durationInDays = trip.tripLogEntries.first?.daysInCountry ?? 1
        let firstCountry = trip.tripLogEntries.first
        let keys = trip.coverages.map { $0.titleLocalizationKey }

        coInsured = trip.coInsured.map { $0.firstNames }
        coverages = keys.compactMap { $0.lowercased().localized() }
        countryName = firstCountry?.countryCode.countryName() ?? "Per day"
        firstCoverage = trip.coverages.first?.titleLocalizationKey.lowercased().localized()
        totalPrice = "\(trip.currentTotalPrice / 100)"
        duration = durationInDays == 1 ? "1 day" : "\(durationInDays) days"

        if durationInDays > 0 {
            pricePerDay = "\(trip.currentTotalPrice / 100 / durationInDays) kr/day"
        } else {
            pricePerDay = "\(trip.currentTotalPrice / 100)"
        }
    }
}
