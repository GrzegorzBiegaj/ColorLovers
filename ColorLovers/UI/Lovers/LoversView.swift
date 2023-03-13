//
//  ContentView.swift
//  ColorLovers
//
//  Created by Grzesiek on 04/03/2023.
//

import SwiftUI

struct LoversView: View {
    @ObservedObject var viewModel = LoversViewModel()
    @State private var pictureType: PictureType = .pattern
    @State private var isViewLoaded = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $pictureType) {
                    Text("Patterns").tag(PictureType.pattern)
                    Text("Palettes").tag(PictureType.palette)
                    Text("Colors").tag(PictureType.color)
                }
                .pickerStyle(.menu)
                List(viewModel.lovers.indices, id: \.self) { index in
                    NavigationLink(destination: PicturesView(lover: viewModel.lovers[index], pictureType: pictureType)) {
                        LoverView(name: viewModel.loverName(index: index) ?? "", details: viewModel.loverDetails(index: index) ?? "")
                    }
                    .task {
                        if viewModel.shouldFetchNextExtries(index: index) {
                            Task { @MainActor in
                                try await viewModel.fetchEntries()
                            }
                        }
                    }
                    .navigationBarTitle("Lovers")
                }
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
    }
    
    private func refreshData() {
        Task { @MainActor in
            try await viewModel.fetchEntries()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoversView()
    }
}
