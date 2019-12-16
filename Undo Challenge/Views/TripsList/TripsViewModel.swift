//
//  TripsViewModel.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 13/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import Foundation

struct TripCellData {
    let country: String
    let dates: String
    let duration: String
    let price: String
}

final class TripsViewModel {
    var trips: [Trip]

    init() {
        trips = Bundle.main.decode([Trip].self, from: "data.json")
    }

    func dataForCell(at indexPath: IndexPath) -> TripCellData {
        let trip = trips[indexPath.item]

        let visitedCountryCodes = trip.tripLogEntries.map { $0.countryCode }
        let firstVisitedCountry = visitedCountryCodes.first!.countryName()
        let firstCountryFlag = visitedCountryCodes.first!.emojiFlag()
        let countryString = firstVisitedCountry! + " " + firstCountryFlag!

        let startDate = formattedDate(from: trip.startDate)
        let endDate = formattedDate(from: trip.endDate)
        let datesString = "\(startDate.prettyDate()) - \(endDate.prettyDate())"

        let duration = trip.tripLogEntries.first?.daysInCountry ?? 0
        let durationString = "\(duration) \(duration < 2 ? "day" : "days")"

        let priceString = "\(trip.currentTotalPrice / 100) kr"

        return TripCellData(country: countryString,
                            dates: datesString,
                            duration: durationString,
                            price: priceString)
    }

    private func formattedDate(from string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)!
    }
}
