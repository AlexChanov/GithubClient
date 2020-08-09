//
//  NetworkService.swift
//  TestGithub
//
//  Created by Алексей Чанов on 07.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    
    var apiWrapper: APIWrapperProtocol { get }
    
    func getRepositories(name: String, complition: @escaping (Result<[RepositoryDescription]?, Error>) -> Void)
    func getAccounts(since: Int, complition: @escaping (Result<[Account]?, Error>) -> Void)
    func getFullInfoAccount(name: String, complition: @escaping (Result<AccountFullInfo?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    public let apiWrapper: APIWrapperProtocol
    
    private let config = URLSessionConfiguration.default
    lazy private var session = URLSession(configuration: config)
    
    init(apiWrapper: APIWrapperProtocol) {
        self.apiWrapper = apiWrapper
    }
    
    // MARK: - Public
    
    public func getRepositories(name: String, complition: @escaping (Result<[RepositoryDescription]?, Error>) -> Void) {
        guard let url = apiWrapper.makeUrlForDescriptionAccount(name: name) else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode([RepositoryDescription].self, from: data)
                complition(.success(objects))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    public func getAccounts(since: Int, complition: @escaping (Result<[Account]?, Error>) -> Void) {
        guard let url = apiWrapper.makeUrlForAccount(since: since) else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode([Account].self, from: data)
                complition(.success(objects))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    public func getFullInfoAccount(name: String, complition: @escaping (Result<AccountFullInfo?, Error>) -> Void) {
        guard let url = apiWrapper.makeFullInfoAccount(name: name) else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(AccountFullInfo.self, from: data)
                complition(.success(objects))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
