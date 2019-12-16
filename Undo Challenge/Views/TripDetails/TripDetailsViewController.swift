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

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var pricePerDayLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var coversStack: UIStackView!
    @IBOutlet private weak var firstCoverageLabel: UILabel!
    @IBOutlet private weak var coveragesStack: UIStackView!

    private let viewModel: TripDetailsViewModel
    weak var delegate: TripListDelegate?

    private let impactGenerator = UIImpactFeedbackGenerator(style: .soft)

    init(viewModel: TripDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    private func setupView() {
        containerView.layer.cornerRadius = 14
        impactGenerator.prepare()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    // Change to bidings
    private func setupData() {
        totalPriceLabel.text = viewModel.totalPrice
        countryLabel.text = viewModel.countryName
        pricePerDayLabel.text = viewModel.pricePerDay
        durationLabel.text = viewModel.duration
        firstCoverageLabel.text = viewModel.firstCoverage

        viewModel.coInsured.forEach { (firstName) in
            let coInsuredLabel = UILabel()
            coInsuredLabel.text = firstName
            coInsuredLabel.font = .systemFont(ofSize: 12)
            coInsuredLabel.textColor = .secondaryLabel
            coversStack.addArrangedSubview(coInsuredLabel)
        }

        if !viewModel.coverages.isEmpty {
            viewModel.coverages.removeFirst()
            viewModel.coverages.forEach { (coverageKey) in
                let coverageLabel = UILabel()
                coverageLabel.text = coverageKey
                coverageLabel.font = .systemFont(ofSize: 12)
                coverageLabel.textColor = .secondaryLabel
                coveragesStack.addArrangedSubview(coverageLabel)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        applyCutoutShapeMask(for: containerView)
    }

    @IBAction private func dismissButtonAction(_ sender: Any) {
        impactGenerator.impactOccurred()
        delegate?.dismissPopup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Cutout shape calculations
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
