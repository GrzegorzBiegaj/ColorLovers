//
//  NetworkingMock.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 12/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class NetworkingMock: RequestConnectionProtocol {
    
    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?
    
    init (data: Data? = nil, error: Error? = nil, response: HTTPURLResponse? = nil) {
        self.data = data
        self.error = error
        self.response = response
    }
    
    func performRequest<Req: RequestProtocol>(request: Req, handler: @escaping (Result<Req.InterpreterType.SuccessType, Req.InterpreterType.ErrorType>) -> Void) {
        
        let res = request.interpreter.interpret(data: data, response: response, error: error, successStatusCode: request.successStatusCode)
        handler(res)
    }
}
