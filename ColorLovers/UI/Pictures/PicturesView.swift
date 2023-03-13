//
//  PicturesView.swift
//  ColorLovers
//
//  Created by Grzesiek on 06/03/2023.
//

import SwiftUI

struct PicturesView: View {
    @ObservedObject var viewModel: PicturesViewModel
    @State private var isViewLoaded = false
    var lover: Lover
    var pictureType: PictureType

    init(lover: Lover, pictureType: PictureType) {
        self.lover = lover
        self.pictureType = pictureType
        self.viewModel = PicturesViewModel(numberOfPictures: LoversViewModel().numberOfPictures(lover: lover, pictureType: .pattern))
    }

    var body: some View {
        List(viewModel.pictures.indices, id: \.self) { index in
            let name = viewModel.pictureName(index: index) ?? ""
            let details = viewModel.pictureDetails(index: index) ?? ""
            let url = viewModel.pictures[index].imageUrl

            NavigationLink(destination: ImageView(title: name, url: url)) {
                PictureView(name: name, details: details, url: url)
            }
            .task {
                if viewModel.shouldFetchNextExtries(index: index) {
                    Task { @MainActor in
                        try await viewModel.fetchEntries(userName: lover.userName, pictureType: .pattern)
                    }
                }
            }
            .navigationBarTitle(lover.userName, displayMode: .inline)
        }
        .onAppear {
            if !isViewLoaded {
                refreshData()
                isViewLoaded = true
            }
        }
        .refreshable {
            refreshData()
        }
    }
    
    private func refreshData() {
        Task { @MainActor in
            try await viewModel.fetchEntries(userName: lover.userName, pictureType: pictureType)
        }
    }
}

struct PicturesView_Previews: PreviewProvider {
    static var previews: some View {
        PicturesView(lover: Lover(userName: "User", numColors: 0, numPalettes: 0, numPatterns: 0, rating: 0), pictureType: .pattern)
    }
}
