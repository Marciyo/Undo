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
    let trips = Bundle.main.decode([Trip].self, from: "data.json")

    func dataForCell(at indexPath: IndexPath) -> TripCellData {
        let trip = trips[indexPath.item]

        let countriesVisited = trip.tripLogEntries.map { $0.countryCode }
        let firstVisitedCountry = countryName(for: countriesVisited.first!)
        let firstCountryEmoji = countryEmoji(for: countriesVisited.first!)
        let countryString = firstVisitedCountry! + " " + firstCountryEmoji

        let startDate = Date.getFormattedDate(from: trip.startDate)
        let endDate = Date.getFormattedDate(from: trip.endDate)
        let datesString = "\(startDate.prettyDate()) - \(endDate.prettyDate())"

        let durationString = prepareDurationString(between: startDate, and: endDate)

        let priceString = "\(trip.currentTotalPrice / 100) kr"

        return TripCellData(country: countryString,
                            dates: datesString,
                            duration: durationString,
                            price: priceString)
    }

    private func prepareDurationString(between date1: Date, and date2: Date) -> String {
        let unitFlags = Set<Calendar.Component>([.day, .hour, .minute, .second])
        let durationComponents = Calendar.current.dateComponents(unitFlags,
                                                                 from: date1,
                                                                 to: date2)

        if let days = durationComponents.day, days != 0 {
            return days == 1 ? "1 day" : "\(days) days"
        } else if let hours = durationComponents.hour, hours != 0 {
            return hours == 1 ? "1 hour" : "\(hours) hours"
        } else if let minutes = durationComponents.minute, minutes != 0 {
            return minutes == 1 ? "1 minute" : "\(minutes) minutes"
        } else if let seconds = durationComponents.second, seconds != 0 {
            return seconds == 1 ? "1 second" : "\(seconds) seconds"
        } else {
            return "Less than 1 second"
        }
    }

    private func countryName(for countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }

    private func countryEmoji(for countryCode: String) -> String {
        let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value

        var string: String = ""

        countryCode.uppercased().unicodeScalars.forEach {
            if let scalar = UnicodeScalar(base + $0.value) {
                string.append(String(describing: scalar))
            }
        }

        return string
    }
}
