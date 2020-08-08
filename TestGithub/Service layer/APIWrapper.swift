//
//  APIWrapper.swift
//  TestGithub
//
//  Created by Алексей Чанов on 07.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation

protocol APIWrapperProtocol {
    
    func makeUrlForAccount(since: Int) -> URL?
    func makeUrlForDescriptionAccount(name: String) -> URL?
}

struct APIWrapper: APIWrapperProtocol {
   
    public func makeUrlForDescriptionAccount(name: String) -> URL? {
        let baseURL = "https://api.github.com/users/\(name)/repos"  //page=2&per_page=100'
        var urlCompanents = URLComponents(string: baseURL)

        let count = URLQueryItem(name: "per_page", value: "20")

        urlCompanents?.queryItems = [count]
        
        return urlCompanents?.url ?? nil
    }
    
    
    public func makeUrlForAccount(since: Int) -> URL? {
        let baseURL = "https://api.github.com/users"
        var urlCompanents = URLComponents(string: baseURL)

        let count = URLQueryItem(name: "per_page", value: "20")
        let since = URLQueryItem(name: "since", value: since.description)
        
        urlCompanents?.queryItems = [count, since]

        return urlCompanents?.url ?? nil
    }
}
