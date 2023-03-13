//
//  InterpreterProtocol.swift
//  ColorLoversList
//
//  Created by Grzesiek on 08/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

protocol NetworkResponseInterpreter {
    associatedtype SuccessType
    associatedtype ErrorType: Error
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?, successStatusCode: Int) -> Result<SuccessType, ErrorType>
}
