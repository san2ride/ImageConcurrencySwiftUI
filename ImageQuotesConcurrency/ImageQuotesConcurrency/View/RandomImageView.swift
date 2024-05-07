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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RandomImageView()
}
