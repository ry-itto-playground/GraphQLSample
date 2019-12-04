//
//  ContentViewModel.swift
//  GraphQLSample
//
//  Created by 伊藤凌也 on 2019/12/04.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Combine

final class ContentViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []

    // Input
    enum Input {
        case onAppear
    }
    let onAppearSubject = PassthroughSubject<Void, Never>()

    // Output
    @Published private(set) var userData: AuthUserQuery.Data?
    let userDataSubject = PassthroughSubject<AuthUserQuery.Data?, Never>()

    init() {
        let authUserClient = AuthUserClient()

        onAppearSubject
            .flatMap { authUserClient.publisher }
            .subscribe(userDataSubject)
            .store(in: &cancellables)

        userDataSubject
            .assign(to: \.userData, on: self)
            .store(in: &cancellables)
    }
}
