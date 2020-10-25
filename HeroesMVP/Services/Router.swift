//
//  Router.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 16.10.2020.
//

import UIKit

protocol  RouterMain {
    var navigationController: UINavigationController {get set}
    var moduleBuilder: ModuleBuilderProtocol {get set}
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol)
}

protocol RouterProtocol: RouterMain {
    func createInitialViewController()
    func pushDetailViewController(hero: Hero)
    func popToRoot()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    var moduleBuilder: ModuleBuilderProtocol
    
    required init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func createInitialViewController() {
        let viewController = moduleBuilder.createMainHeroScreen(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func pushDetailViewController(hero: Hero) {
        let detailHerpViewController = moduleBuilder.createDetailHeroScreen(hero: hero, router: self)
        navigationController.pushViewController(detailHerpViewController, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
