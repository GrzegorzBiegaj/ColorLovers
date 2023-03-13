//
//  ImageStorage.swift
//  ColorLovers
//
//  Created by Grzesiek on 08/03/2023.
//

import SwiftUI

class ImageStorage {
    private var inMemoryStorage = InMemoryStorage.sharedInstance
    
    func store(url: URL, image: Image) {
        var newImagesData = ImagesData()
        if let imagesData = restoreImages() {
            newImagesData = imagesData
        } else {
            let imagesDisctionary = [URL: Image]()
            newImagesData.imagesDisctionary = imagesDisctionary
        }
        newImagesData.imagesDisctionary![url] = image
        inMemoryStorage.store(newImagesData)
    }
    
    func restore(url: URL) -> Image? {
        if let imagesData = restoreImages(), let imagesDisctionary = imagesData.imagesDisctionary, let image = imagesDisctionary[url] {
            return image
        } else {
            return nil
        }
    }
    
    private func restoreImages() -> ImagesData? {
        let imagesData: ImagesData? = inMemoryStorage.tryRestore()
        return imagesData
    }
}
