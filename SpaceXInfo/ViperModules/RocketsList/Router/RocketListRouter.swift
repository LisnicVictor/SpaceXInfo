//
//  RocketListRouter.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

protocol RocketListRouterInput {
    func openInfoModule(with rocket:Rocket)
}

struct RocketListRouter: RocketListRouterInput {
    
    weak var transitionHandler: ViperModuleTransitionHandler!
    
    func openInfoModule(with rocket: Rocket) {
        transitionHandler.openModule(defaultSegueIdentifierFor: RocketInfoViewController.self,
                                     configurator: RocketInfoConfigurator(),
                                     customTransitioningDelegate: nil) { (input) in
            guard let input = input as? RocketInfoModuleInput else {return}
            input.config(with: rocket)
        }
    }
}

