//
//  RocketInfoConfigurator.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

struct RocketInfoConfigurator: ViperModuleConfigurator {
    func configure(with viewInput: UIViewController) {
        guard let viewInput = viewInput as? RocketInfoViewController else {return}
        let presenter = RocketInfoPresenter()
        presenter.view = viewInput
        viewInput.output = presenter
    }
}
