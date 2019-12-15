//
//  TripsViewController.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 13/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

final class TripsViewController: UIViewController {

    @IBOutlet private weak var headerView: TripsHeaderView!
    @IBOutlet private weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)

    private let viewModel: TripsViewModel
    weak var delegate: TripListDelegate?

    init(viewModel: TripsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        headerView.updateTripCount(to: viewModel.trips.count)
        impactGenerator.prepare()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.trips.count
    }

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
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        impactGenerator.impactOccurred()
        delegate?.showTripDetails(for: viewModel.trips[indexPath.item])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPos = tableView.contentOffset.y
        let calculatedHeaderHeight: CGFloat = headerViewHeightConstraint.constant - yPos

        if calculatedHeaderHeight > HeaderLayout.maxHeight {
            headerViewHeightConstraint.constant = HeaderLayout.maxHeight
        } else if calculatedHeaderHeight < HeaderLayout.minHeight {
            headerViewHeightConstraint.constant = HeaderLayout.minHeight
        } else {
            headerViewHeightConstraint.constant = calculatedHeaderHeight
            scrollView.contentOffset.y = 0
        }
    }

//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let min = HeaderConstants.minHeight
//        let max = HeaderConstants.maxHeight
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
