//
//  Accounts.swift
//  TestGithub
//
//  Created by Алексей Чанов on 08.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import Foundation

struct Accounts: Decodable {
   
    let login: String?
    let avatar_url: String?
    let type: String?
    let id: Int?
}
