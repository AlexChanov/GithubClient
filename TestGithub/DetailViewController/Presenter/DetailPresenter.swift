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
    func succes(url: URL?)
    func failure(title: String, message: String)
    
}

protocol DetailViewPresenter: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, account: Account?)
    
    var account: AccountFullInfo? { get set }
    var model: [RepositoryDescription]? { get set }
    
    func getDate() -> String
}

final class DetailPresenter: DetailViewPresenter {
    
    private weak var view: DetailViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    
    public var account: AccountFullInfo?
    public var model: [RepositoryDescription]?
    
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, account: Account?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        
        getFullInfo(name: account?.login ?? "")
        getRepositories(name: account?.login ?? "")
    }
    
    // MARK: - Private
    
    private func getRepositories(name: String) {
        networkService.getRepositories(name: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):
                self.model = repositories
                self.view?.succes()
            case .failure(_):
                self.view?.failure(title: "Не удалось получить список репозиториев", message: "Попробуйте позже")
            }
        }
    }
    
    private func getFullInfo(name: String) {
        networkService.getFullInfoAccount(name: name) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let account):
                self.account = account
                let urlImage = URL(string: account?.avatar_url ?? "")
                self.view?.succes(url: urlImage)
            case .failure(_):
                self.view?.failure(title: "Не удалось получить полную информациб об аккаунте", message: "Попробуйте позже")
            }
        }
    }
    
    // MARK: - Public
    
    public func getDate() -> String {
        if let index = account?.created_at?.range(of: "T")?.lowerBound,
            let substring = account?.created_at?[..<index] {
            let string = String(substring)
            return "Дата создания \(string)"
        }
        return ""
    }
}
