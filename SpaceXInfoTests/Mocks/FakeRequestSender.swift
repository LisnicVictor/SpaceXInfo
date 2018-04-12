//
//  FakeRequestSender.swift
//  SpaceXInfoTests
//
//  Created by Victor Lisnic on 4/12/18.
//  Copyright © 2018 Lisnic Victor. All rights reserved.
//

import Foundation
import LVNetworkAdapter
import LVResult

enum FakeRequestSenderError: Error {
    case connectionError
}

class FakeRequestSender: LVRequestSending {
    var errorInterpreter: LVErrorInterpreting?

    var stubData: Data?
    var url: URL?
    var requestMethod: HttpMethod?
    var sendRequestIsCalled: Bool = false
    var error: FakeRequestSenderError?

    func send(request: LVRequestType, completion: ((Result<Data?>) -> ())?) {
        sendRequestIsCalled = true
        url = request.request.url
        requestMethod = request.method

        if let error = error {
            completion?(.error(error))
        } else {
            completion?(.success(stubData))
        }
    }
}
