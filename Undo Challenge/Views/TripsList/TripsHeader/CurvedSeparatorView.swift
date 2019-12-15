//
//  CurvedSeparatorView.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

@IBDesignable
final class CurvedSeparatorView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        applyShapeMask()
    }

    private func applyShapeMask() {
        let path = UIBezierPath()

        let outerRadius: CGFloat = 13
        let middleCurveWidth: CGFloat = 34
        let middleCurveHeight: CGFloat = 11

        let width = frame.width
        let height = frame.height

        path.move(to: CGPoint(x: 0, y: height))

        path.addArc(withCenter: CGPoint(x: outerRadius, y: height),
                    radius: outerRadius,
                    startAngle: CGFloat(180.0).toRadians(),
                    endAngle: CGFloat(270.0).toRadians(),
                    clockwise: true)

        path.addLine(to: CGPoint(x: width / 2 - middleCurveWidth / 2, y: 0))

        path.addCurve(to: CGPoint(x: width / 2, y: middleCurveHeight),
                      controlPoint1: CGPoint(x: width / 2 - 10,
                                             y: 0),
                      controlPoint2: CGPoint(x: width / 2 - 6,
                                             y: 11))

        path.addCurve(to: CGPoint(x: width / 2 + middleCurveWidth / 2, y: 0),
                      controlPoint1: CGPoint(x: width / 2 + 6,
                                             y: 11),
                      controlPoint2: CGPoint(x: width / 2 + 10,
                                             y: 0))

        path.addArc(withCenter: CGPoint(x: width - outerRadius, y: height),
                    radius: outerRadius,
                    startAngle: CGFloat(270.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: true)

        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath

        layer.mask = shapeLayer
    }
}
