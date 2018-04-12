//
//  RocketInfoViewController.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

protocol RocketInfoModuleInput: ViperModuleInput {
    func config(with rocket: Rocket)
}

class RocketInfoPresenter {
    weak var view: RocketInfoViewInput!
    var rocket: Rocket?
}

extension RocketInfoPresenter: RocketInfoViewOutput {
    func viewDidLoad() {
        guard let rocket = rocket else {return}
        let viewModel = RocketInfoViewModel(name: rocket.name,
                                            isActive: rocket.active,
                                            type: rocket.type,
                                            firstFlightFormattedString: rocket.firstFlight,
                                            height: rocket.height.meters,
                                            diameter: rocket.diameter.meters,
                                            mass: rocket.mass.kg,
                                            numberOfStages: rocket.stages,
                                            numberOfBoosters: rocket.boosters,
                                            successRate: rocket.successRatePct,
                                            costPerLaunch: rocket.costPerLaunch)
        view.config(with: viewModel)
    }
}

extension RocketInfoPresenter: RocketInfoModuleInput {
    func config(with rocket: Rocket) {
        self.rocket = rocket
    }
}
