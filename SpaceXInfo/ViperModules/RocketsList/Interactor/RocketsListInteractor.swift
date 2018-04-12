//
//  File.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
import LVResult

protocol RocketsListInteractorInput {
    func getRockets()
}

protocol RocketsListInteractorOutput: class {
    func didGetRockets(result:Result<[Rocket]>)
}

struct RocketsListInteractor: RocketsListInteractorInput {
    
    weak var output: RocketsListInteractorOutput?
    let rocketsFetcher: RocketsInfoFetching
    
    func getRockets() {
        rocketsFetcher.fetchRocketsInfo {[weak output = output] result in
            output?.didGetRockets(result: result)
        }
    }
}
