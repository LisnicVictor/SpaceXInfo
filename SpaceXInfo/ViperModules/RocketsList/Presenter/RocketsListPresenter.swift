//
//  RocketsListPresenter.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

class RocketsListPresenter {
    
    var view: RocketsListViewInput!
    var interactor: RocketsListInteractorInput!
    var router: RocketListRouterInput!
    
    var rockets = [Rocket]()
}

extension RocketsListPresenter: RocketsListViewOutput {
    func viewDidLoad() {
        interactor.getRockets()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let rocket = rockets[indexPath.item]
        router.openInfoModule(with: rocket)
    }
    
    func item(at indexPath: IndexPath) -> RocketCellViewModel {
        let rocket = rockets[indexPath.item]
        let rocketViewModel = RocketCellViewModel(title: rocket.name, isActive: rocket.active)
        return rocketViewModel
    }
    
    func numberOfItems() -> Int {
        return rockets.count
    }
}

extension RocketsListPresenter: RocketsListInteractorOutput {
    func didGetRockets(result: Result<[Rocket]>) {
        do {
            rockets = try result.resolve()
            DispatchQueue.main.async {
                self.view.reloadCollection()
            }
        } catch {
            print(error)
        }
    }
}
