//
//  TripsViewController.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 13/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

final class TripsViewController: UIViewController {

    @IBOutlet private weak var headerViewHeightConstraint: NSLayoutConstraint! {
        didSet {

        }
    }
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = TripsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.trips.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TripTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel.dataForCell(at: indexPath))
        return cell
    }
}

extension TripsViewController: UITableViewDelegate {
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TripTableViewCell.self)

        //        let path = UIBezierPath()
        //        let width = tableView.frame.width
        //        let height = tableView.frame.height
        //        path.move(to: tableView.frame.origin)
        //        path.addLine(to: CGPoint(x: width / 2 - 17,
        //                                 y: tableView.frame.minY))
        //
        //        path.addCurve(to: CGPoint(x: width / 2 + 17,
        //                                  y: tableView.frame.minY),
        //                                  controlPoint1: CGPoint(x: width - 5, y: tableView.frame.minY + 12),
        //                                  controlPoint2: CGPoint(x: width + 5, y: tableView.frame.minY + 30))
        //
        //        path.addLine(to: CGPoint(x: width, y: tableView.frame.minY))
        //        path.addLine(to: CGPoint(x: width, y: height))
        //        path.addLine(to: CGPoint(x: 0, y: height))
        //        path.close()
        //
        //        let shapeLayer = CAShapeLayer()
        //        shapeLayer.path = path.cgPath
        //
        //        tableView.layer.mask = shapeLayer
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPos = tableView.contentOffset.y
        let calculatedHeaderHeight: CGFloat = headerViewHeightConstraint.constant - yPos

        if calculatedHeaderHeight > HeaderConstants.headerViewMaxHeight {
            headerViewHeightConstraint.constant = HeaderConstants.headerViewMaxHeight
        } else if calculatedHeaderHeight < HeaderConstants.headerViewMinHeight {
            headerViewHeightConstraint.constant = HeaderConstants.headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = calculatedHeaderHeight
            scrollView.contentOffset.y = 0
        }
    }

//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let min = HeaderConstants.headerViewMinHeight
//        let max = HeaderConstants.headerViewMaxHeight
//        if headerViewHeightConstraint.constant > (max + min) / 2 {
//            headerViewHeightConstraint.constant = max
//        } else {
//            headerViewHeightConstraint.constant = min
//        }
//        UIView.animate(withDuration: 3.5) {
//            self.view.layoutIfNeeded()
//        }
//    }
}
