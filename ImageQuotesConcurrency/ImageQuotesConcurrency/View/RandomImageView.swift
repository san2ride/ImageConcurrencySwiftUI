//
//  RandomImageView.swift
//  ImageQuotesConcurrency
//
//  Created by Jason Sanchez on 5/7/24.
//

import SwiftUI

struct RandomImageView: View {
    
    @StateObject private var randomImageListVM = RandomImageListVM()
    
    var body: some View {
        List(randomImageListVM.randomImages) { randomImage in
            HStack {
                randomImage.image.map {
                    Image(uiImage: $0)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Text(randomImage.quote)
            }
        }.task {
            await randomImageListVM.getRandomImages(ids: Array(100...120))
        }
    }
}

#Preview {
    RandomImageView()
}
