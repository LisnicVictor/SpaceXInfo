//
//  URLs.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation

struct URLs {
    static var base = URL(string: "https://api.spacexdata.com/v2/")!
    static var getRocketsInfo = base.appendingPathComponent("rockets")
}
