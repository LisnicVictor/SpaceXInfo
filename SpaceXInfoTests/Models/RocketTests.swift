//
//  RocketTests.swift
//  SpaceXInfoTests
//
//  Created by Victor Lisnic on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
import XCTest
@testable import SpaceXInfo

class RocketTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testItShouldBeCreatedWithCorrectFieldsFromJson() {

        let testBundle = Bundle(for:FakeRequestSender.self)
        let path = testBundle.path(forResource: "FakeSingleRocketDataJson", ofType: "txt")!
        let data = try! Data.init(contentsOf: URL.init(fileURLWithPath: path))
        do {
            let rocket = try Rocket(data: data)


            XCTAssertEqual(rocket.id, "falconheavy")
            XCTAssertEqual(rocket.name, "Falcon Heavy")
            XCTAssertEqual(rocket.type, "rocket")
            XCTAssertTrue(rocket.active)
            XCTAssertEqual(rocket.stages, 2)
            XCTAssertEqual(rocket.costPerLaunch, 90000000)
            XCTAssertEqual(rocket.successRatePct, 100)
            XCTAssertEqual(rocket.firstFlight, "2018-02-06")
            XCTAssertEqual(rocket.country, "United States")
            XCTAssertEqual(rocket.company, "SpaceX")

            XCTAssertEqual(rocket.height.meters, 70)
            XCTAssertEqual(rocket.height.feet, 229.6)

            XCTAssertEqual(rocket.diameter.meters, 12.2)
            XCTAssertEqual(rocket.diameter.feet, 39.9)

            XCTAssertEqual(rocket.mass.kg, 1420788)
            XCTAssertEqual(rocket.mass.lb, 3125735)


            XCTAssertEqual(rocket.boosters, 2)
            XCTAssertEqual(rocket.boosters, 2)

            XCTAssertEqual(rocket.payloadWeights[0].id, "leo")
            XCTAssertEqual(rocket.payloadWeights[0].name, "Low Earth Orbit")
            XCTAssertEqual(rocket.payloadWeights[0].kg, 63800)
            XCTAssertEqual(rocket.payloadWeights[0].lb, 140660)

            XCTAssertTrue(rocket.firstStage.reusable)
            XCTAssertEqual(rocket.firstStage.engines, 27)
            XCTAssertEqual(rocket.firstStage.fuelAmountTons, 1155)
            XCTAssertEqual(rocket.firstStage.cores, 3)
            XCTAssertEqual(rocket.firstStage.burnTimeSEC, 162)

            XCTAssertEqual(rocket.firstStage.thrustSeaLevel.kN, 22819)
            XCTAssertEqual(rocket.firstStage.thrustSeaLevel.lbf, 5130000)

            XCTAssertEqual(rocket.firstStage.thrustVacuum.kN, 24681)
            XCTAssertEqual(rocket.firstStage.thrustVacuum.lbf, 5548500)

            XCTAssertEqual(rocket.secondStage.engines, 1)
            XCTAssertEqual(rocket.secondStage.burnTimeSEC, 397)
            XCTAssertEqual(rocket.secondStage.thrust.kN, 934)
            XCTAssertEqual(rocket.secondStage.thrust.lbf, 210000)
            XCTAssertEqual(rocket.secondStage.payloads.option1, "dragon")
            XCTAssertEqual(rocket.secondStage.payloads.option2, "composite fairing")
            XCTAssertEqual(rocket.secondStage.payloads.compositeFairing.height.meters, 13.1)
            XCTAssertEqual(rocket.secondStage.payloads.compositeFairing.height.feet, 43)
            XCTAssertEqual(rocket.secondStage.payloads.compositeFairing.diameter.meters, 5.2)
            XCTAssertEqual(rocket.secondStage.payloads.compositeFairing.diameter.feet, 17.1)

            XCTAssertEqual(rocket.engines.number, 27)
            XCTAssertEqual(rocket.engines.type, "merlin")
            XCTAssertEqual(rocket.engines.version, "1D+")
            XCTAssertEqual(rocket.engines.layout, "octaweb")
            XCTAssertEqual(rocket.engines.engineLossMax, 6)
            XCTAssertEqual(rocket.engines.propellant1, "subcooled liquid oxygen")
            XCTAssertEqual(rocket.engines.propellant2, "RP-1 kerosene")

            XCTAssertEqual(rocket.engines.thrustSeaLevel.kN, 845)
            XCTAssertEqual(rocket.engines.thrustSeaLevel.lbf, 190000)
            XCTAssertEqual(rocket.engines.thrustVacuum.kN, 914)
            XCTAssertEqual(rocket.engines.thrustVacuum.lbf, 205500)
            XCTAssertEqual(rocket.engines.thrustToWeight, 180.1)

            XCTAssertEqual(rocket.landingLegs.number, 12)
            XCTAssertEqual(rocket.landingLegs.material, "carbon fiber")

            XCTAssertEqual(rocket.description, "With the ability to lift into orbit over 54 metric tons (119,000 lb)--a mass equivalent to a 737 jetliner loaded with passengers, crew, luggage and fuel--Falcon Heavy can lift more than twice the payload of the next closest operational vehicle, the Delta IV Heavy, at one-third the cost.")


        } catch {
            XCTFail(error.localizedDescription)
        }

    }

    func testItShouldThrowAnErrorIfDataIsNil() {
        XCTAssertThrowsError(try Rocket(data: nil), "shold throw error with description that data is nil") { (error) in
            print(error)
        }
    }

    func testItShouldThrowAnErrorIfDataIsInvalid() {
        let data = "{\"invalidData\" : 0}".data(using: .utf8)
        XCTAssertThrowsError(try Rocket(data: data), "shold throw a decoding error") { (error) in
            print(error)
        }
    }
}
