//
//  Comment.swift
//  app
//
//  Created by Максим Ефимов on 11.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import Foundation

class Comment {
    let user_id: Int!
    let text: String!
    let date: String!
    
    init(user_id: Int, text: String, date: String){
        self.user_id = user_id
        self.text = text
        self.date = date
    }
}
