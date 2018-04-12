//
//  FakeRocketInfoFetcher.swift
//  SpaceXInfoTests
//
//  Created by Victor Lisnic on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
@testable import SpaceXInfo

class FakeRocketInfoFetcher: RocketsInfoFetching {

    var stubData: Data?

    func fetchRocketsInfo(with completion: @escaping (Result<[Rocket]>) -> ()) {
        do {
            let rockets = try [Rocket](data:stubData)
            completion(.success(rockets))
        } catch {
            completion(.error(error))
        }
    }
}
