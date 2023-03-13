//
//  LoversViewModel.swift
//  ColorLovers
//
//  Created by Grzesiek on 04/03/2023.
//

import Foundation

@MainActor class LoversViewModel: ObservableObject {
    private let loverController: LoverControllerProtocol

    private(set) var listOffset = 0
    @Published var lovers: [Lover] = []

    init (loverController: LoverControllerProtocol = LoverController()) {
        self.loverController = loverController
    }
    
    func fetchEntries() async throws {
        lovers = try await loverController.lovers(offset: listOffset)
    }

    func clearData() {
        loverController.clearCahe()
        listOffset = 0
    }

    func shouldFetchNextExtries(index: Int) -> Bool {
        return lovers.count > 0 && index == lovers.count - 1
    }

    func loverName(index: Int) -> String? {
        guard index >= 0 && index < lovers.count else { return nil }
        let lover = lovers[index]
        return "\(lover.userName) (rating: \(lover.rating))"
    }

    func loverDetails(index: Int) -> String? {
        guard index >= 0 && index < lovers.count else { return nil }
        let lover = lovers[index]
        return "Patterns: \(lover.numPatterns), Palletes: \(lover.numPalettes), Colors: \(lover.numColors)"
    }

    func numberOfPictures(lover: Lover?, pictureType: PictureType?) -> Int {
        guard let lover = lover, let pictureType = pictureType else { return 0 }
        switch pictureType {
        case .pattern: return lover.numPatterns
        case .palette: return lover.numPalettes
        case .color: return lover.numColors
        }
    }
}
