//
//  Models.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 14/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import Foundation

struct Trip: Codable {
    let id: String
    let startDate: String
    let endDate: String
    let currentTotalPrice: Int
    let tripLogEntries: [TripLog]
    let coInsured: [CoInsured]
    let coverages: [Coverage]
}

struct TripLog: Codable {
    let countryCode: String
    let daysInCountry: Int
}

struct CoInsured: Codable {
    let id: String
    let firstNames: String
    let lastName: String?
}

struct Coverage: Codable {
    let titleLocalizationKey: String
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
