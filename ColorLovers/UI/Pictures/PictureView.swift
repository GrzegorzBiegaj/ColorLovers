//
//  PictureView.swift
//  ColorLovers
//
//  Created by Grzesiek on 06/03/2023.
//

import SwiftUI

struct PictureView: View {
    var name: String
    var details: String
    var url: String

    var body: some View {
        HStack {
            CacheAsyncImage(url:  URL(string: url)!) { phase in
                if let image = phase.image {
                    image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 40, maxHeight: 40)
                } else {
                    ProgressView()
                }
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(verbatim: name)
                    .font(.system(size: 16))
                Text(verbatim: details)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(name: "name", details: "details", url: "")
    }
}

