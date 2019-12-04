//
//  ContentView.swift
//  GraphQLSample
//
//  Created by 伊藤凌也 on 2019/12/04.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            ImageURL(url: URL(string: viewModel.userData?.viewer.avatarUrl ?? ""))
                .clipShape(Circle())
            Text(viewModel.userData?.viewer.name ?? "")
                .onAppear {
                    self.viewModel.onAppearSubject.send(())
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
