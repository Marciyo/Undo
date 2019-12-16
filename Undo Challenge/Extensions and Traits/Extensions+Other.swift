//
//  Extensions+Other.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

extension CGFloat {
    func toRadians() -> CGFloat { self * .pi / 180 }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func countryName() -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: self)
    }

    func emojiFlag() -> String? {
        let code = self.uppercased()

        guard Locale.isoRegionCodes.contains(code) else {
            return nil
        }

        var flagString = ""

        for s in code.unicodeScalars {
            guard let scalar = UnicodeScalar(127397 + s.value) else {
                continue
            }
            flagString.append(String(scalar))
        }
        return flagString
    }
}
