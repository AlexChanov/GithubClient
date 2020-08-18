//
//  MainPresenterTest.swift
//  TestGithubTests
//
//  Created by Алексей Чанов on 17.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import XCTest
@testable import TestGithub

class MockView: MainViewProtocol {
    
    var failerTitleTest: String?
    var failerMessageTest: String?
    
    func swapElement(first: IndexPath, second: IndexPath) {
        
    }
    
    func succes() {
        
    }
    
    func failure(title: String, message: String) {
        failerTitleTest = title
        failerMessageTest = message
    }
}

class MockNetworkService: NetworkServiceProtocol {
    
    var accounts: [Account]!
    var repository: [RepositoryDescription]!
    var accountFullInfo: AccountFullInfo!
    
    var apiWrapper: APIWrapperProtocol
    var session: URLSession
    
    init() {
        apiWrapper = APIWrapper()
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
        
    convenience init(accounts: [Account]?, repositories: [RepositoryDescription], accountFullInfo: AccountFullInfo) {
        self.init()
        self.accounts = accounts
        self.repository = repositories
        self.accountFullInfo = accountFullInfo
    }
    
    func getRepositories(name: String, completion: @escaping (Result<[RepositoryDescription]?, Error>) -> Void) {
        if let repository = repository {
            completion(.success(repository))
        } else {
            let error = NSError(domain: "", code: 1, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func getAccounts(since: Int, completion: @escaping (Result<[Account]?, Error>) -> Void) {
        if let accounts = accounts {
            completion(.success(accounts))
        } else {
            let error = NSError(domain: "", code: 1, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func getFullInfoAccount(name: String, completion: @escaping (Result<AccountFullInfo?, Error>) -> Void) {
        if let accountFullInfo = accountFullInfo {
            completion(.success(accountFullInfo))
        } else {
            let error = NSError(domain: "", code: 1, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class MainPresenterTest: XCTestCase {
    
    var modelAccounts = [Account]()
    var modelRepositories = [RepositoryDescription]()
    var accountInfo: AccountFullInfo!
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkService!
    var router: RouterProtocol!
    
    override func setUp(){
        let navigationController = UINavigationController()
        let assembly = AssemblerModelBuilder()
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }
    
    func testGetSuccesData()  {
        let account = Account(login: "Alex", avatar_url: "account", type: "publuc", id: 3)
        modelAccounts.append(account)
        let repository = RepositoryDescription(name: "alex", language: "swift", stargazers_count: 0, updated_at: "22/06/22")
        modelRepositories.append(repository)
        let accountFullInfo = AccountFullInfo(login: "alex", avatar_url: "image", name: "vetrov", created_at: "22/06/22", location: "Russia")
        accountInfo = accountFullInfo
        
        view = MockView()

        let networkService = MockNetworkService(accounts: modelAccounts, repositories: modelRepositories, accountFullInfo: accountInfo)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchAccounts: [Account]?
        var catchRepositoryDescription: [RepositoryDescription]?
        var catchAccountFullInfo: AccountFullInfo?
        
        networkService.getAccounts(since: 0) { (result) in
            switch result {
            case .success(let account):
                catchAccounts = account
            case .failure(let error):
                print(error)
            }
        }
        
        networkService.getRepositories(name: "alexchanov") { (result) in
            switch result {
            case .success(let repository):
                catchRepositoryDescription = repository
            case .failure(let error):
                print(error)
            }
        }
        
        networkService.getFullInfoAccount(name: "alexchanov") { (result) in
            switch result {
            case .success(let model):
                catchAccountFullInfo = model
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchAccounts?.count, 0)
        XCTAssertNotEqual(catchRepositoryDescription?.count, 0)
        XCTAssertNotNil(catchAccountFullInfo)
        XCTAssertEqual(catchAccounts?.count, modelAccounts.count)
    }
}
