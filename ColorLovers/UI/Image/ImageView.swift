//
//  ImageView.swift
//  ColorLovers
//
//  Created by Grzesiek on 07/03/2023.
//

import SwiftUI

struct ImageView: View {
    
    let title: String
    let url: String
    
    var body: some View {
        VStack {
            Text(title)
            CacheAsyncImage(url:  URL(string: url)!) { phase in
                if let image = phase.image {
                    image.resizable(resizingMode: .tile)
                } else {
                    ProgressView()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(title: "", url: "")
    }
}
