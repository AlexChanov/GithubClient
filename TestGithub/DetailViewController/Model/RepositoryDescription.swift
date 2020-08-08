//
//  FirstModel.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation

struct RepositoryDescription: Decodable {
    
    var name: String?
    var owner: Owner?
}

struct Owner: Decodable {

    var login: String?
    var type: String?
    var avatar_url: String?
}
