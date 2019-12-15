//
//  TripsHeaderView.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 14/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

struct HeaderLayout {
    static let maxHeight: CGFloat = 350
    static let minHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.height
}

@IBDesignable
final class TripsHeaderView: UIView {

    private let travelHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Your travel\nhistory"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(descriptor: UIFontDescriptor(name: "KohinoorTelugu-Light", size: 40), size: 40)
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let tripsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "32"
        label.textColor = .white
        label.font = .systemFont(ofSize: 100)
        return label
    }()


    private let tripsDescLabel: UILabel = {
        let label = UILabel()
        label.text = "trips"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        return label
    }()

    private func setupView() {
        addSubview(travelHistoryLabel)
        travelHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            travelHistoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            travelHistoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        ])

        let tripsStack = UIStackView(arrangedSubviews: [tripsCountLabel, tripsDescLabel])
        tripsStack.alignment = .firstBaseline
        tripsStack.spacing = 6

        addSubview(tripsStack)
        tripsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tripsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            tripsStack.topAnchor.constraint(equalTo: centerYAnchor, constant: -8)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let minHeight = HeaderLayout.minHeight
        let maxHeight = HeaderLayout.maxHeight

        let halfWay = (minHeight + maxHeight) / 2
        let progress = (frame.height - halfWay) / (maxHeight - halfWay)
        travelHistoryLabel.alpha = progress

        let tripCountLabelSize = 100 * frame.height / maxHeight
        tripsCountLabel.font = .systemFont(ofSize: tripCountLabelSize)
    }

    func updateTripCount(to count: Int) {
        tripsCountLabel.text = "\(count)"
    }
}
