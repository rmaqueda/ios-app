//
//  Comment.swift
//  app
//
//  Created by Максим Ефимов on 11.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import Foundation

class Comment {
    let user: User!
    let text: String!
    let date: String!
    
    init(user: User, text: String, date: String){
        self.user = user
        self.text = text
        self.date = date
    }
}
