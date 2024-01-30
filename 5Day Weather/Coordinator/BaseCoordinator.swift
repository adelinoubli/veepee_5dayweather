//
//  BaseCoordinator.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation

class BaseCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }
}
