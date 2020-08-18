//
//  RouterTest.swift
//  TestGithubTests
//
//  Created by Алексей Чанов on 18.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import XCTest
@testable import TestGithub

class MockNavigationController: UINavigationController {
    
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

class RouterTest: XCTestCase {

    var router: RouterProtocol!
    var assemblyBuilder = AssemblerModelBuilder()
    var navigationController = MockNavigationController()
    
    override func setUp() {
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }
    
    override func tearDown() {
        router = nil
    }

    func testRouter() {
        router.showDetail(account: Account(login: "alexchanov", avatar_url: "github", type: "public", id: 1))
        let detailViewcontroller = navigationController.presentedVC
        XCTAssertTrue(detailViewcontroller is DetailViewController)
    }
}
