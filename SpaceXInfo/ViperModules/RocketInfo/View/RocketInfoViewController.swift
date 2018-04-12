//
//  RocketInfoViewController.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

struct RocketInfoViewModel {
    let name: String
    let isActive: Bool
    let type: String
    let firstFlightFormattedString: String
    let height: Double
    let diameter: Double
    let mass: Int
    let numberOfStages: Int
    let numberOfBoosters: Int
    let successRate: Int
    let costPerLaunch: Int
}

protocol RocketInfoViewOutput  {
    func viewDidLoad()
}

protocol RocketInfoViewInput: class {
    func config(with viewModel:RocketInfoViewModel)
}

class RocketInfoViewController: ViperViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isActiveLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var firstFlightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var numberOfStagesLabel: UILabel!
    @IBOutlet weak var numberOfBoostersLabel: UILabel!
    @IBOutlet weak var successRateLabel: UILabel!
    @IBOutlet weak var costPerLaunchLabel: UILabel!
    
    var output: RocketInfoViewOutput!
    
    override var moduleInput: ViperModuleInput? {
        return output as? ViperModuleInput
    }
    
    override func viewDidLoad() {
        output.viewDidLoad()
    }
}

extension RocketInfoViewController: RocketInfoViewInput {
    func config(with viewModel: RocketInfoViewModel) {
        
        title = viewModel.name
        
        nameLabel.text = viewModel.name
        isActiveLabel.text = viewModel.isActive ? "Yes" : "No"
        typeLabel.text = viewModel.type
        firstFlightLabel.text = viewModel.firstFlightFormattedString
        heightLabel.text = "\(viewModel.height) m"
        diameterLabel.text = "\(viewModel.diameter) m"
        massLabel.text = "\(viewModel.mass) kg"
        numberOfStagesLabel.text = "\(viewModel.numberOfStages)"
        numberOfBoostersLabel.text = "\(viewModel.numberOfBoosters)"
        successRateLabel.text = "\(viewModel.successRate)%"
        costPerLaunchLabel.text = "\(viewModel.costPerLaunch)$"
    }
}
