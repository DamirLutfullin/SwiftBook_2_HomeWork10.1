//
//  Presenter.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import UIKit

protocol StartHeroPresenterProtocol: class {
    func setHeroesForView()
    func setFilteresHeroes(searchQuery: String)
    func showDetailView(hero: Hero)
}

final class StartHeroPresenter: StartHeroPresenterProtocol {
   
    private var router: Router
    private weak var heroView: StartHeroViewProtocol!
    private var heroes: [Hero]?
    private var filteredHeroes: [Hero]?
    
    required init(view: StartHeroViewProtocol?, router: Router) {
        self.heroView = view
        self.router = router
    }
    
    func setHeroesForView() {
        NetworkManager.shared.downloadHeroes { [weak self] (result) in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.heroView.showHeroes(heroes: heroes)
            case .failure(let error):
                self?.heroView.showError(error: error)
            }
        }
    }
    
    func setFilteresHeroes(searchQuery: String) {
        self.filteredHeroes = heroes?.filter({ (hero) -> Bool in
            return hero.name.contains(searchQuery)
        })
        heroView.showHeroes(heroes: filteredHeroes)
    }
    
    func showDetailView(hero: Hero) {
        router.pushDetailViewController(hero: hero)
    }
}
