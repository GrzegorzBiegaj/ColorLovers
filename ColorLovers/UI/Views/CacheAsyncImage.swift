//
//  CacheAsyncImage.swift
//  ColorLovers
//
//  Created by Grzesiek on 07/03/2023.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    let storage = ImageStorage()
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
            self.url = url
            self.scale = scale
            self.transaction = transaction
            self.content = content
    }
    
    var body: some View {
        if let cached = storage.restore(url: url) {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction) { phase in
                    render(phase: phase)
            }
        }
    }
    
    func render(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            storage.store(url: url, image: image)
        }
        return content(phase)
    }

}

struct CacheAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CacheAsyncImage(url: URL(string: "")!) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            case .failure:
                ProgressView()
            @unknown default:
                fatalError()
            }
        }
    }
}
