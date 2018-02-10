//
//  User.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import Foundation
// id, first_name, last_name, username, photo_url, auth_date and hash

class User {
    let id : Int!
    let first_name: String?
    let last_name: String?
    let username: String?
    let photo_url: String?
    
    init(id: Int, first_name: String?, last_name: String?, username: String?, photo_url: String?) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.username = username
        self.photo_url = photo_url
    }
}
