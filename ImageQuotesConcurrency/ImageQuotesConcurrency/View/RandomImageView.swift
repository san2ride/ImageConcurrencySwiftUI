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
        NavigationView {
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
            .navigationTitle("Deep Thoughts")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await randomImageListVM.getRandomImages(ids: Array(100...120))
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
        }
    }
}

#Preview {
    RandomImageView()
}
