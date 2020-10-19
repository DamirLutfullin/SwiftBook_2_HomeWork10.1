//
//  Presenter.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import UIKit

protocol StartHeroPresenterProtocol: class {
    var heroes: [Hero]? {get set}
    var router: Router {get set}
    init(view: StartHeroViewProtocol?, network: NetworkManagerProtocol, router: Router)
    func downloadComments()
    func showDetailView(hero: Hero)
}

class StartHeroPresenter: StartHeroPresenterProtocol {
    
    var router: Router
    weak var heroView: StartHeroViewProtocol!
    var network: NetworkManagerProtocol!
    var heroes: [Hero]?
    
    
    required init(view: StartHeroViewProtocol?, network: NetworkManagerProtocol, router: Router) {
        self.heroView = view
        self.network = network
        self.router = router
        self.downloadComments()
    }
    
    func downloadComments() {
        network.getHeroes { [weak self] (result) in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.heroView.showHeroes()
            case .failure(let error):
                self?.heroView.showError(error: error)
            }
        }
    }
    
    func showDetailView(hero: Hero) {
        router.pushDetailViewController(hero: hero)
    }
}
