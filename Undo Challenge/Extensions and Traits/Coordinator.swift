//
//  Coordinator.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 15/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func add(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }

    func remove(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
