//
//  TripDetailsViewController.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

@IBDesignable
final class TripDetailsViewController: UIViewController {

    private enum Layout {
        static let outerCornerRadius: CGFloat = 10
        static let cutoutCornerRadius: CGFloat = 15
        static let cutoutRelativePosition: CGFloat = 1/3
    }

    @IBOutlet private weak var container: UIView!
    private let impactGenerator = UIImpactFeedbackGenerator(style: .soft)
    weak var delegate: TripListDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        container.layer.cornerRadius = 14
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        impactGenerator.prepare()
    }

    override func viewDidLayoutSubviews() {
        applyCutoutShapeMask(for: container)
    }

    @IBAction private func dismissButtonAction(_ sender: Any) {
        impactGenerator.impactOccurred()
        delegate?.dismissPopup()
    }
}

extension TripDetailsViewController {
    fileprivate func applyCutoutShapeMask(for view: UIView) {
        let path = UIBezierPath()

        let width = view.frame.width
        let height = view.frame.height

        path.move(to: CGPoint(x: 0.0, y: 0.0))

        ///Left side
        path.addLine(to: CGPoint(x: 0.0, y: height * Layout.cutoutRelativePosition - Layout.cutoutCornerRadius))
        path.addArc(withCenter: CGPoint(x: 0, y: height * Layout.cutoutRelativePosition),
                    radius: Layout.cutoutCornerRadius,
                    startAngle: CGFloat(270.0).toRadians(),
                    endAngle: CGFloat(90.0).toRadians(),
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0.0, y: height))

        ///Bottom side
        path.addLine(to: CGPoint(x: width, y: height))

        ///Right side
        path.addLine(to: CGPoint(x: width, y: height * Layout.cutoutRelativePosition + Layout.cutoutCornerRadius))
        path.addArc(withCenter: CGPoint(x: width, y: height * Layout.cutoutRelativePosition),
                    radius: Layout.cutoutCornerRadius,
                    startAngle: CGFloat(90.0).toRadians(),
                    endAngle: CGFloat(270.0).toRadians(),
                    clockwise: true)
        path.addLine(to: CGPoint(x: width, y: 0))

        ///Top side
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath

        view.layer.mask = shapeLayer
    }
}
