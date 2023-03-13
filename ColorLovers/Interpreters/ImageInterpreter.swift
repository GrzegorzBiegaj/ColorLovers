//
//  ImageInterpreter.swift
//  ColorLoversList
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import UIKit

class ImageInterpreter: NetworkResponseInterpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?, successStatusCode: Int) -> Result<UIImage, ResponseError> {
        
        if let _ = error { return Result.failure(ResponseError.connectionError) }
        guard response?.statusCode == successStatusCode else {
            return Result.failure(ResponseError.invalidResponseError)
        }
        guard let data = data else { return Result.failure(ResponseError.invalidResponseError) }
        guard let image = UIImage(data: data, scale: UIScreen.main.scale) else { return Result.failure(ResponseError.decodeError) }
        return Result.success(image)
    }
}
