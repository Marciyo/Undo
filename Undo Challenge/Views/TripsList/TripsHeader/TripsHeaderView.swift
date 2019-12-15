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
            tripsStack.topAnchor.constraint(equalTo: centerYAnchor)
        ])
        applyShapeMask()

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

// MARK: - Shape configuration
extension TripsHeaderView {
    fileprivate func applyShapeMask() {
        let path = UIBezierPath()

        let outerRadius: CGFloat = 13
//        let middleCurveWidth: CGFloat = 34

        let width = frame.width
        let height = frame.height

        path.move(to: CGPoint(x: 0, y: height))

        path.addArc(withCenter: CGPoint(x: outerRadius, y: height),
                    radius: outerRadius,
                    startAngle: CGFloat(180.0).toRadians(),
                    endAngle: CGFloat(270.0).toRadians(),
                    clockwise: true)

//        path.addLine(to: CGPoint(x: 0.0, y: height))

        path.addArc(withCenter: CGPoint(x: width - outerRadius, y: height),
                    radius: outerRadius,
                    startAngle: CGFloat(270.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: true)

        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath

        shapeLayer.fillColor = UIColor.systemBackground.cgColor

        layer.addSublayer(shapeLayer)
    }
}
