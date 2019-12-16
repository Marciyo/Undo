//
//  TripDetailsViewModelTests.swift
//  Undo ChallengeTests
//
//  Created by Marcel Mierzejewski on 16/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import XCTest
@testable import Undo_Challenge

class TripDetailsViewModelTests: XCTestCase {

    var viewModel: TripDetailsViewModel!

    override func setUp() {
        let trips = Bundle.main.decode([Trip].self, from: "data.json")
        XCTAssertNotNil(trips.first)
        viewModel = TripDetailsViewModel(trip: trips.first!)
    }

    func testTripDetailsViewModel() {
        XCTAssertEqual(viewModel.countryName, "Spain")
        XCTAssertEqual(viewModel.duration, "6 days")
        XCTAssertEqual(viewModel.totalPrice, "78")
        XCTAssertEqual(viewModel.coInsured.first, nil)
    }
}
