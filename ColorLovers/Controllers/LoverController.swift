//
//  LoverController.swift
//  ColorLoversList
//
//  Created by Grzesiek on 09/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

protocol LoverControllerProtocol {

    var numberOfElements: Int { get }
    var lovers: [Lover] { get }
    var connection: RequestConnectionProtocol { get }

    func lovers(offset: Int, handler: @escaping (Result<[Lover], ResponseError>) -> ())
    func lovers(offset: Int) async throws -> [Lover] 
    func sortLoversByRatingAndName(lovers: [Lover]) -> [Lover]
    func clearCahe()
}

class LoverController: LoverControllerProtocol {

    var numberOfElements = 100
    var lovers = [Lover]()
    var connection: RequestConnectionProtocol
    
    init (connection: RequestConnectionProtocol = RequestConnection()) {
        self.connection = connection
    }

    func lovers(offset: Int) async throws -> [Lover] {
        try await withCheckedThrowingContinuation { continuation in
            let request = LoversRequest(offset: offset, number: numberOfElements)
            connection.performRequest(request: request) { (response) in
                switch response {
                case .success(let lovers):
                    self.lovers += self.sortLoversByRatingAndName(lovers: lovers)
                    continuation.resume(returning: (self.lovers))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func lovers(offset: Int, handler: @escaping (Result<[Lover], ResponseError>) -> ()) {
        let request = LoversRequest(offset: offset, number: numberOfElements)
        connection.performRequest(request: request) { (response) in
            
            switch response {
            case .success(let lovers):
                self.lovers += self.sortLoversByRatingAndName(lovers: lovers)
                handler(.success(self.lovers))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func sortLoversByRatingAndName(lovers: [Lover]) -> [Lover] {
        var lov = lovers.filter { $0.numPatterns > 0 }
        lov.sort { $0.rating == $1.rating ? $0.userName < $1.userName : $0.rating > $1.rating }
        return lov
    }
    
    func clearCahe() {
        lovers = []
    }
}
