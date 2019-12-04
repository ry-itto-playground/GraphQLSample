//
//  AuthUserClient.swift
//  GraphQLSample
//
//  Created by 伊藤凌也 on 2019/12/04.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Combine

struct AuthUserClient {
    var publisher: AuthUserClientPublisher {
        AuthUserClientPublisher()
    }
}

extension AuthUserClient {
    struct AuthUserClientPublisher: Publisher {
        typealias Output = AuthUserQuery.Data?
        typealias Failure = Never

        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            Network.shared.apollo.fetch(query: AuthUserQuery()) { result in
                switch result {
                case .success(let data):
                    _ = subscriber.receive(data.data)
                case .failure:
                    _ = subscriber.receive(nil)
                }
            }
        }
    }
}
