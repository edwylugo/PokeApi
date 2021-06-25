//
//  MainTabBarCoordinator.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let controller = MainTabController()
        presenter.pushViewController(controller, animated: false)
    }
    
}
