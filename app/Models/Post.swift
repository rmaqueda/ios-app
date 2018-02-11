//
//  Post.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import Foundation

class Post {
    var id: Int
    var url : String!
    var imgUrl : String?
    var title : String!
    var comments: [Comment]?
    
    init (id: Int, url : String, imgUrl: String?, title: String, comments: [Comment]?){
        self.id = id
        self.url = url
        self.imgUrl = imgUrl
        self.title = title
        self.comments = comments
    }
}
