//
//  SpaceXInfoTests.swift
//  SpaceXInfoTests
//
//  Created by Lisnic Victor on 4/11/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import XCTest
@testable import SpaceXInfo

class RocketsInfoFetcherTests: XCTestCase {

    var requestSenderStub = FakeRequestSender()
    var sut: RocketsInfoFetcher!

    override func setUp() {
        super.setUp()
        sut = RocketsInfoFetcher(requestSender: requestSenderStub)
    }
    
    override func tearDown() {
        super.tearDown()
        requestSenderStub.error = nil
        requestSenderStub.stubData = nil
    }
    
    func testItShouldCallRequestManager() {
        sut.fetchRocketsInfo { _ in }
        XCTAssert(requestSenderStub.sendRequestIsCalled)
    }

    func testItShoudProvideCorrectUrlAndHTTPMethod() {
        sut.fetchRocketsInfo {_ in}

        XCTAssert(requestSenderStub.requestMethod! == .GET)
        XCTAssert(requestSenderStub.url! == URLs.getRocketsInfo)
    }

    func testItReturnesValidRocketsArrayWithValidData() {

        let expect = expectation(description: "It should return valid array of rockets")
        let testBundle = Bundle(for:FakeRequestSender.self)
        let path = testBundle.path(forResource: "FakeRocketDataJson", ofType: "txt")!

        requestSenderStub.stubData = try? Data(contentsOf: URL(fileURLWithPath:path))

        sut.fetchRocketsInfo { result in
            do {
                let rockets: [Rocket] = try result.resolve()
                XCTAssert(!rockets.isEmpty)
            } catch {
                XCTFail(expect.description + " " + error.localizedDescription)
            }
            expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if error != nil {
                XCTFail( expect.description + " " + error!.localizedDescription)
            }
        }
    }

    func testItShouldReturnAnErrorIfDataIsNil() {
        let expect = expectation(description: "It should return an error if data is nil")

        requestSenderStub.stubData = nil

        sut.fetchRocketsInfo { result in

            do {
                XCTAssertThrowsError(try result.resolve(), "should throw an error", { error in
                    print(error.localizedDescription)
                })
            } catch {}

            expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if error != nil {
                XCTFail( expect.description + " " + error!.localizedDescription)
            }
        }
    }

    func testItShouldReturnErrorIfDataIsNotValid() {
        let expect = expectation(description: "It should return an error if data is not valid")

        requestSenderStub.stubData = "{ \"wrongData\" : 1 }".data(using: .utf8)

        sut.fetchRocketsInfo { result in

            do {
                XCTAssertThrowsError(try result.resolve(), "should throw an error", { error in
                    print(error.localizedDescription)
                })
            } catch {}

            expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if error != nil {
                XCTFail( expect.description + " " + error!.localizedDescription)
            }
        }
    }

    func testItShouldReturnAnEmptyArrayIfDataIsEmpty() {
        let expect = expectation(description: "It should return an empty array if data is empty")

        requestSenderStub.stubData = "[]".data(using: .utf8)

        sut.fetchRocketsInfo { result in

            do {
                let rockets = try result.resolve()
                XCTAssert(rockets.isEmpty)
            } catch {
                XCTFail(expect.description + " " + error.localizedDescription)
            }

            expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if error != nil {
                XCTFail( expect.description + " " + error!.localizedDescription)
            }
        }
    }

    func testItShouldPropagateServerErrors() {
        let expect = expectation(description: "It should propagate server errors")

        requestSenderStub.stubData = nil
        requestSenderStub.error = FakeRequestSenderError.connectionError

        sut.fetchRocketsInfo { result in

            do {
                let rockets = try result.resolve()
                XCTFail("should throw an error")
            } catch {
                XCTAssertNotNil((error as? FakeRequestSenderError))
                XCTAssert((error as! FakeRequestSenderError) == .connectionError)
            }

            expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if error != nil {
                XCTFail( expect.description + " " + error!.localizedDescription)
            }
        }
    }
}
