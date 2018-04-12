//
//  RocketsListConfigurator.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

class RocketListInitializer: NSObject {
    
    @IBOutlet weak var viewInput: RocketsListViewController!
    
    override func awakeFromNib() {
        RocketsListConfigurator().configure(with: viewInput)
    }
}

struct RocketsListConfigurator: ViperModuleConfigurator {
    func configure(with viewInput: UIViewController) {
        guard let viewInput = viewInput as? RocketsListViewController else {return}
        
        let presenter = RocketsListPresenter()
        let interactor = RocketsListInteractor(output: presenter, rocketsFetcher: RocketsInfoFetcher())
        let router = RocketListRouter(transitionHandler: viewInput)
        presenter.interactor = interactor
        presenter.view = viewInput
        presenter.router = router
        viewInput.output = presenter
    }
}
