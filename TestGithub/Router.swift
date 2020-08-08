//
//  Router.swift
//  TestGithub
//
//  Created by Алексей Чанов on 08.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

protocol RouterMain {
    
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblerBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    
    func initialViewController()
    func showDetail(account: Account)
    func popToRoot()
}


final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblerBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    public func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    public func showDetail(account: Account) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(router: self, account: account) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    public func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
