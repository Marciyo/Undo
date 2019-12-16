//
//  Extensions+Date.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import Foundation

extension Date {
    func prettyDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        return dateFormatter.string(from: self)
    }
}
