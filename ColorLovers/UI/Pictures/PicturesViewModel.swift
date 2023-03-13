//
//  PicturesViewModel.swift
//  ColorLovers
//
//  Created by Grzesiek on 06/03/2023.
//

import Foundation

@MainActor class PicturesViewModel: ObservableObject {
    
    fileprivate let pictureController: PictureControllerProtocol
    private(set) var listOffset = 0
    private(set) var listShorterThanExpected = false

    @Published var pictures: [Picture] = []
    var numberOfPictures: Int

    init (numberOfPictures: Int, pictureController: PictureControllerProtocol = PictureController()) {
        self.numberOfPictures = numberOfPictures
        self.pictureController = pictureController
    }

    func fetchEntries(userName: String?, pictureType: PictureType) async throws {
        guard let userName = userName else { return }
        let pictures = try await pictureController.pictures(offset: listOffset, userName: userName, pictureType: pictureType)
        // Protect against less elements than expected
        if pictures.count - self.listOffset != self.pictureController.numberOfElements {
            self.listShorterThanExpected = true
        }
        self.listOffset += self.pictureController.numberOfElements
        self.pictures = pictures
    }

    func clearData() {
        pictureController.clearCahe()
        listOffset = 0
    }
    
    func shouldFetchNextExtries(index: Int) -> Bool {
        return index == pictures.count - 1 &&
            pictures.count < numberOfPictures &&
            !listShorterThanExpected
    }

    func pictureName(index: Int) -> String? {
        guard index >= 0 && index < pictures.count else { return nil }
        return pictures[index].title
    }

    func pictureDetails(index: Int) -> String? {
        guard index >= 0 && index < pictures.count else { return nil }
        let picture = pictures[index]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        var dateString = "???"
        dateString = dateFormatter.string(from: picture.dateCreated as Date)
        return "Date: \(dateString), Votes: \(picture.numVotes)"
    }
}
