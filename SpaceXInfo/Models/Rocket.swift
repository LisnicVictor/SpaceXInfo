//
//  Rocket.swift
//  SpaceXInfo
//
//  Created by Lisnic Victor on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
import LVNetworkAdapter

struct Rocket: JSONModel {
    let id: String
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: String
    let country: String
    let company: String
    let height: Length
    let diameter: Length
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case active = "active"
        case stages = "stages"
        case boosters = "boosters"
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country = "country"
        case company = "company"
        case height = "height"
        case diameter = "diameter"
        case mass = "mass"
        case payloadWeights = "payload_weights"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines = "engines"
        case landingLegs = "landing_legs"
        case description = "description"
    }
}

struct Length: JSONModel {
    let meters: Double
    let feet: Double
    
    enum CodingKeys: String, CodingKey {
        case meters = "meters"
        case feet = "feet"
    }
}

struct Engines: JSONModel {
    let number: Int
    let type: String
    let version: String
    let layout: String
    let engineLossMax: Int
    let propellant1: String
    let propellant2: String
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let thrustToWeight: Double
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case type = "type"
        case version = "version"
        case layout = "layout"
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case thrustToWeight = "thrust_to_weight"
    }
}

struct Thrust: JSONModel {
    let kN: Int
    let lbf: Int
    
    enum CodingKeys: String, CodingKey {
        case kN = "kN"
        case lbf = "lbf"
    }
}

struct FirstStage: JSONModel {
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let cores: Int?
    
    enum CodingKeys: String, CodingKey {
        case reusable = "reusable"
        case engines = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case cores = "cores"
    }
}

struct LandingLegs: JSONModel {
    let number: Int
    let material: String?
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case material = "material"
    }
}

struct Mass: JSONModel {
    let kg: Int
    let lb: Int
    
    enum CodingKeys: String, CodingKey {
        case kg = "kg"
        case lb = "lb"
    }
}

struct PayloadWeight: JSONModel {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case kg = "kg"
        case lb = "lb"
    }
}

struct SecondStage: JSONModel {
    let engines: Int
    let fuelAmountTons: Double?
    let burnTimeSEC: Int
    let thrust: Thrust
    let payloads: Payloads
    
    enum CodingKeys: String, CodingKey {
        case engines = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
        case thrust = "thrust"
        case payloads = "payloads"
    }
}

struct Payloads: JSONModel {
    let option1: String
    let compositeFairing: CompositeFairing
    let option2: String?
    
    enum CodingKeys: String, CodingKey {
        case option1 = "option_1"
        case compositeFairing = "composite_fairing"
        case option2 = "option_2"
    }
}

struct CompositeFairing: JSONModel {
    let height: Length
    let diameter: Length
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case diameter = "diameter"
    }
}
