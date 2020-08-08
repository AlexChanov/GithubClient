//
//  FirstPresenter.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation


protocol MainViewProtocol: class {
    func succes()
    func failure()
}

protocol MainViewPresenter: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    
    var model: [Accounts]? { get set }
    
    func searchAccounts(name: String)
    func getAccountsList(id: Int)
}

final class MainPresenter: MainViewPresenter {
    
    private weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    public var model : [Accounts]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getAccountsList(id: 0)
    }
    
    public func searchAccounts(name: String) {
        

//        networkService.getRepositories(name: name) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let repositories):
//                self.model = repositories
//                self.view?.succes()
//            case .failure(_):
//                self.view?.failure()
//                print("failer")
//            }
//        }
    }
    
    
    public func getAccountsList(id: Int) {
        networkService.getAccounts(since: id) { [weak self] (result) in
            switch result {
            case .success(let repositories):
                self?.model = repositories
                self?.view?.succes()
            case .failure(_):
                self?.view?.failure()
                print("failer")
            }
        }
    }
}
