//
//  RandomImageListVM.swift
//  ImageQuotesConcurrency
//
//  Created by Jason Sanchez on 5/7/24.
//

import UIKit

// MARK: @MainActor = main thread
@MainActor
class RandomImageListVM: ObservableObject {
    
    @Published var randomImages: [RandomImageViewModel] = []
    
    func getRandomImages(ids: [Int]) async {
        do {
            let randomImages = try await WebService().getRandomImages(ids: ids)
            self.randomImages = randomImages.map(RandomImageViewModel.init)
        } catch {
            print(error)
        }
    }
}

struct RandomImageViewModel: Identifiable {
    let id = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
