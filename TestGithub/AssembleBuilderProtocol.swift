//
//  Builder.swift
//  TestGithub
//
//  Created by Алексей Чанов on 07.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit


protocol AssemblerBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol, account: Account?) -> UIViewController
}


final class AssemblerModelBuilder: AssemblerBuilderProtocol {
    
    public func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService(apiWrapper: APIWrapper())
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
     public func createDetailModule(router: RouterProtocol,account: Account?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService(apiWrapper: APIWrapper())
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, account: account)
        view.presenter = presenter

        return view
    }
}


