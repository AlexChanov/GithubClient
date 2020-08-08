//
//  DetailPresenter.swift
//  TestGithub
//
//  Created by Алексей Чанов on 08.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func succes()
    func failure(title: String, message: String)
    
}

protocol DetailViewPresenter: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, account: Account?)
    
    var model: [RepositoryDescription]? { get set }
}

final class DetailPresenter: DetailViewPresenter {
    
    private weak var view: DetailViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    private let account: Account?
    
    public var model: [RepositoryDescription]?
    
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, account: Account?) {
        self.view = view
        self.networkService = networkService
        self.account = account
        self.router = router
        getRepositories()
    }
    
    public func getRepositories() {
        networkService.getRepositories(name: account?.login ?? "") { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let repositories):
                 self.model = repositories
                 self.view?.succes()
             case .failure(_):
                self?.view?.failure(title: "Пороблемы с соединением", message: "Попробуйте позже")
             }
         }
    }
    
    public func tapBack() {
//        router.popToRoot()
    }
}
