//
//  NibReusableView.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 12/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

typealias NibReusableView = NibLoadableView & ReusableView

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String { String(describing: self) }
}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String { String(describing: self) }
}
