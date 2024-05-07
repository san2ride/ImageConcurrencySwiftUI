//
//  Constants.swift
//  ImageQuotesConcurrency
//
//  Created by Jason Sanchez on 5/7/24.
//

import Foundation

struct Constants {
    
    struct Urls {
        static func getRandomImageUrl() -> URL? {
            return URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        }
        static let randomQuoteUrl: URL? = URL(string: "https://api.quotable.io/random")
    }
}
