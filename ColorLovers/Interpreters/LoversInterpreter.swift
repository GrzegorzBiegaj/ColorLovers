//
//  LoversInterpreter.swift
//  ColorLoversList
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

class LoversInterpreter: NetworkResponseInterpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?, successStatusCode: Int) -> Result<[Lover], ResponseError> {
        
        if let _ = error { return Result.failure(ResponseError.connectionError) }
        guard response?.statusCode == successStatusCode else {
            return Result.failure(ResponseError.invalidResponseError)
        }
        guard let data = data else { return Result.failure(ResponseError.invalidResponseError) }
        guard let response = try? JSONDecoder().decode([Lover].self, from: data) else {
            return Result.failure(ResponseError.decodeError)
        }
        return Result.success(response)
    }
}
