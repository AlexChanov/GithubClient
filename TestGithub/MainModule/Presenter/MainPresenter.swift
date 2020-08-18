//
//  FirstPresenter.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation


protocol MainViewProtocol: class {
    
    func swapElement(first: IndexPath, second: IndexPath)
    func succes()
    func failure(title: String, message: String)
}

protocol MainViewPresenter: class {
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var model: [Account]? { get set }
    
    func searchAccounts(name: String)
    func getAccountsList(id: Int)
    func uploadAccountList(_ indexRow: Int)
    func sortedModel()
    func tapOnTheAccount(indexRow: Int)
}

final class MainPresenter: MainViewPresenter {
    
    private weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol?
    
    public var model: [Account]? = [Account]()
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getAccountsList()
    }
    
    // MARK: - Public
    
    public func searchAccounts(name: String) {
        if let value = (model?.firstIndex(where: { $0.login == name })) {
            model?.swapAt(value, 0)
            view?.swapElement(first: IndexPath(row: value, section: 0), second: IndexPath(row: 0, section: 0))
        } else {
            view?.failure(title: "Аккаунт не найдет", message: "Попробуйте снова")
        }
    }
    
    public func getAccountsList(id: Int = 0) {
        networkService.getAccounts(since: id) { [weak self] (result) in
            switch result {
            case .success(let repositories):
                guard let repositories = repositories else { return }
                self?.model?.append(contentsOf: repositories)
                self?.model?.removeDuplicates()
                self?.view?.succes()
            case .failure(_):
                self?.view?.failure(title: "Пороблемы с соединением", message: "Попробуйте позже")
            }
        }
    }
    
    public func uploadAccountList(_ indexRow: Int) {
        guard let elementCount = model?.count, let id = model?.last?.id else { return }
        if (elementCount  - indexRow) == 5 {
            getAccountsList(id: id)
        }
    }
    
    public func sortedModel() {
        let sortedArray = model?.filter { $0.login != nil }.sorted { $0.login!.lowercased() < $1.login!.lowercased() }
        model = sortedArray
        view?.succes()
    }
    
    public func tapOnTheAccount(indexRow: Int) {
        guard let account = model?[indexRow] else { return }
        router?.showDetail(account: account)
    }
}
