//
//  Network.swift
//  GraphQLSample
//
//  Created by 伊藤凌也 on 2019/12/04.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Apollo
import Foundation

class Network {
    static let shared = Network()

    private(set) lazy var githubToken: String? = {
        guard let plistFile = Bundle.main.path(forResource: "GitHubToken", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: plistFile),
            let token = plist["token"] as? String
        else { return nil }

        return token
    }()

    private(set) lazy var apollo = { () -> ApolloClient in 
        let transport = HTTPNetworkTransport(url: URL(string: "https://api.github.com/graphql")!, delegate: self)
        return ApolloClient(networkTransport: transport)
    }()
}

extension Network: HTTPNetworkTransportPreflightDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        return githubToken != nil
    }

    func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
        var header: [String:String] = request.allHTTPHeaderFields ?? [:]
        header["Authorization"] = "Bearer \(githubToken!)"

        request.allHTTPHeaderFields = header
    }
}
