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
        let webservice = WebService()
        //MARK: init images again
        randomImages = []
        
        do {
            try await withThrowingTaskGroup(of: (Int, RandomImage).self,
                                            body: { group in
                // MARK: Perform request
                for id in ids {
                    group.addTask {
                        return (id, try await webservice.getRandomImage(id: id))
                    }
                }
                // MARK: adding request to published property randomImages
                for try await (_, randomImage) in group {
                    randomImages.append(RandomImageViewModel(randomImage: randomImage))
                }
            })
            /*
            let randomImages = try await WebService().getRandomImages(ids: ids)
            self.randomImages = randomImages.map(RandomImageViewModel.init)
            */
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
