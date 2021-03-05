//
//  AssamblyModuleBuilder.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 16.10.2020.
//

import Foundation

protocol ModuleBuilderProtocol: class {
    func createMainHeroScreen(router: Router) -> StartHeroView
    func createDetailHeroScreen(hero: Hero, router: Router) -> DetailHeroViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    
    func createMainHeroScreen(router: Router) -> StartHeroView {
        let mainHeroViewController = StartHeroView()
        let presenter = StartHeroPresenter(view: mainHeroViewController, router: router)
        mainHeroViewController.heroPresenter = presenter
        return mainHeroViewController
    }
    
    func createDetailHeroScreen(hero: Hero, router: Router) -> DetailHeroViewController {
        let view = DetailHeroViewController()
        let presenter = DetailHeroPresenter(view: view, hero: hero, router: router)
        view.presenter = presenter
        return view
    }
}

