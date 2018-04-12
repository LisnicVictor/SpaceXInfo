//
//  RocketsInfoFetcher.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
import LVResult
import LVNetworkAdapter

protocol RocketsInfoFetching {
    func fetchRocketsInfo(with completion:@escaping(Result<[Rocket]>)->())
}

struct RocketsInfoFetcher: RocketsInfoFetching {
    
    var requestSender: LVRequestSending = LVRequestSender()
    
    func fetchRocketsInfo(with completion: @escaping (Result<[Rocket]>) -> ()) {
        
        let request = LVRequest(with: .GET, url: URLs.getRocketsInfo)
        requestSender.send(request: request) { (result) in
            do {
                let data = try result.resolve()
                completion(.success(try [Rocket](data:data)))
            } catch {
                completion(.error(error))
            }
        }
        
    }
}
