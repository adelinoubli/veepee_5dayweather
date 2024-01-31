//
//  Coordinator.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation

protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    func start()
}

protocol HomeCoordinating {
    var coordinator: HomeCoordinator? {get set}
}

//In case we have child coordinators in use
extension Coordinator {

    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
