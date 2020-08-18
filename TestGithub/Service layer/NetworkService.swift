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
    var session: URLSession { get }
        
    func getRepositories(name: String, completion: @escaping (Result<[RepositoryDescription]?, Error>) -> Void)
    func getAccounts(since: Int, completion: @escaping (Result<[Account]?, Error>) -> Void)
    func getFullInfoAccount(name: String, completion: @escaping (Result<AccountFullInfo?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    public let apiWrapper: APIWrapperProtocol
    public let session: URLSession
    
    init(apiWrapper: APIWrapperProtocol) {
        self.apiWrapper = apiWrapper
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    // MARK: - Public
    
    public func getRepositories(name: String, completion: @escaping (Result<[RepositoryDescription]?, Error>) -> Void) {
        guard let url = apiWrapper.makeUrlForDescriptionAccount(name: name) else { return }
        
        makeRequest(url: url) { (result: Result<[RepositoryDescription], Error>) in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getAccounts(since: Int, completion: @escaping (Result<[Account]?, Error>) -> Void) {
        guard let url = apiWrapper.makeUrlForAccount(since: since) else { return }
        
        makeRequest(url: url) { (result: Result<[Account], Error>) in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getFullInfoAccount(name: String, completion: @escaping (Result<AccountFullInfo?, Error>) -> Void) {
        guard let url = apiWrapper.makeFullInfoAccount(name: name) else { return }
        
        makeRequest(url: url) { (result: Result<AccountFullInfo, Error>) in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: -  Private
    
    private func makeRequest<T: Decodable>(url: URL, completion: @escaping(Result<T, Error>) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(.success(objects))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
