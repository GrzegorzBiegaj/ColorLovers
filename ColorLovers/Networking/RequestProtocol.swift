//
//  RequestProtocol.swift
//  ColorLoversList
//
//  Created by Grzesiek on 08/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var successStatusCode: Int { get }
    var httpMethod: HTTPMethod { get }
    var endpoint: String { get }
    var requestParameters: RequestParameters { get }
    var bodyParameters: BodyParameters { get }
    var headers: Headers { get }

    associatedtype InterpreterType: NetworkResponseInterpreter
    var interpreter: InterpreterType { get }
}

extension RequestProtocol {
    
    var successStatusCode: Int { return 200 }
    var httpMethod: HTTPMethod { return .get }
    var requestParameters: RequestParameters { return nil }
    var bodyParameters: BodyParameters { return nil }
    var headers: Headers { return nil }
}
