//
//  AppCoordinator.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

protocol TripListDelegate: class {
    func showTripDetails(for trip: Trip)
    func dismissPopup()
}

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]

    private let window: UIWindow

    init(window: UIWindow) {
        childCoordinators = []
        self.window = window
    }

    func start() {
        let tripsVC = TripsViewController()
        tripsVC.delegate = self
        window.rootViewController = tripsVC
    }
}


extension AppCoordinator: TripListDelegate {
    func showTripDetails(for trip: Trip) {
        let tripDetails = TripDetailsViewController()
        tripDetails.delegate = self
        tripDetails.modalPresentationStyle = .pageSheet
        window.rootViewController?.present(tripDetails, animated: true)
    }

    func dismissPopup() {
        window.rootViewController?.dismiss(animated: true)
    }
}
