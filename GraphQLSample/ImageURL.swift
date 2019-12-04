//
//  ImageURL.swift
//  GraphQLSample
//
//  Created by 伊藤凌也 on 2019/12/04.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import SwiftUI

struct ImageURL: View {
    @ObservedObject var viewModel: ImageURLViewModel

    init(url: URL?) {
        self.viewModel = ImageURLViewModel(url: url)
    }

    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .scaledToFit()
    }
}

final class ImageURLViewModel: ObservableObject {
    @Published var image = UIImage(systemName: "person.fill")!

    init(url: URL?) {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let imageData = data,
                let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }

        task.resume()
    }
}
