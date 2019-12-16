//
//  ExtensionsTests.swift
//  Undo ChallengeTests
//
//  Created by Marcel Mierzejewski on 16/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import XCTest
@testable import Undo_Challenge

class ExtensionsTests: XCTestCase {

    func testPrettyDate() {
        let date = Date(timeIntervalSince1970: 1234567890)
        XCTAssertEqual(date.prettyDate(), "14-02-09")
    }

    func testCGFloatToRadians() {
        let halfCircleDegrees: CGFloat = 180
        XCTAssertEqual(halfCircleDegrees.toRadians(), .pi)
    }

    func testCountryName() {
        let countryCode = "pl"
        let countryName = countryCode.countryName()
        XCTAssertNotNil(countryName)
        XCTAssertEqual(countryName!, "Poland")
    }

    func testEmojiFlag() {
        let countryCode = "US"
        let countryFlag = countryCode.emojiFlag()
        XCTAssertNotNil(countryFlag)
        XCTAssertEqual(countryFlag!, "🇺🇸")
    }
}
