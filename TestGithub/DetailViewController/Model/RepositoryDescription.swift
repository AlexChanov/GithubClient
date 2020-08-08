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
    var language: String?
    var stargazers_count: Int?
    var updated_at: String?
}


struct AccountFullInfo: Decodable {
    
    var login: String?
    var avatar_url: String?
    var name: String?
    var created_at: String?
    var location: String?
}
