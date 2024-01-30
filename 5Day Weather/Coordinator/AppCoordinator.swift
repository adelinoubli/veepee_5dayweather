//
//  AppCoordinator.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation
import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let myCoordinator = HomeCoordinator(navigationController: navigationController)

        // store child coordinator
        self.store(coordinator: myCoordinator)
        myCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // detect when free it
        myCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: myCoordinator)
        }
    }
}
