//
//  TripsViewModelTests.swift
//  Undo ChallengeTests
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import XCTest
@testable import Undo_Challenge

class TripsViewModelTests: XCTestCase {

    let viewModel = TripsViewModel()

    func testTripsViewModel() {
        let data = viewModel.dataForCell(at: IndexPath(item: 1, section: 1))
        XCTAssertEqual(data.country, "United States 🇺🇸")
        XCTAssertEqual(data.duration, "2 days")
        XCTAssertEqual(data.price, "66 kr")
        XCTAssertEqual(data.dates, "10-05-19 - 13-05-19")
    }
}
