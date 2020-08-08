//
//  Builder.swift
//  TestGithub
//
//  Created by Алексей Чанов on 07.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit


protocol Builder {
     static func createMainModule() -> UIViewController
}


final class ModelBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let apiWrapper = APIWrapper()
        let networkService = NetworkService(apiWrapper: apiWrapper)
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
}


