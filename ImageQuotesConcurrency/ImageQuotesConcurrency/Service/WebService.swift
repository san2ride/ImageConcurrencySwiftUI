//
//  WebService.swift
//  ImageQuotesConcurrency
//
//  Created by Jason Sanchez on 5/7/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
}

class WebService {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        var randomImages: [RandomImage] = []
        
        try await withThrowingTaskGroup(of: (Int, RandomImage).self,
                                        body: { group in
            for id in ids {
                // MARK: group task
                group.addTask { [self] in
                    return (id, try await getRandomImage(id: id))
                }
                // MARK: async let
                /*
                let randomImage = try await getRandomImage(id: id)
                randomImages.append(randomImage)
                */
            }
            for try await (_, randomImage) in group {
                randomImages.append(randomImage)
            }
        })
        return randomImages
    }
    
    func getRandomImage(id: Int) async throws -> RandomImage {
        
        guard let url = Constants.Urls.getRandomImageUrl() else {
            throw NetworkError.badURL
        }
        guard let randomQuoteUrl = Constants.Urls.randomQuoteUrl else {
            throw NetworkError.badURL
        }
        
        // MARK: await/async threads run concurrently
        async let (imageData, _) = try await URLSession.shared.data(from: url)
        async let (randomQuoteData, _) = try await URLSession.shared.data(from: randomQuoteUrl)
        
        // MARK: Decoding json url
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else {
            throw NetworkError.decodingError
        }
        return RandomImage(image: try await imageData, quote: quote)
    }
}
