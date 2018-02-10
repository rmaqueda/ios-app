//
//  Post.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import Foundation
/*
 
 ID = 1;
 comments = "<null>";
 "comments_count" = 0;
 "created_at" = "2018-02-10T14:23:27Z";
 "deleted_at" = "<null>";
 "img_url" = "";
 "likes_count" = 0;
 special = "";
 title = "gosha ili geiorgiy";
 type = "";
 "updated_at" = "2018-02-10T14:23:27Z";
 url = "http://telegra.ph/gosha-ili-geiorgiy-02-10";
 "user_id" = 172699006;
 "views_count" = 8;
 */

class Post {
    var url : String!
    var imgUrl : String?
    var title : String!
    var comments: [Comment]?
    
    init (url : String, imgUrl: String?, title: String, comments: [Comment]?){
        self.url = url
        self.imgUrl = imgUrl
        self.title = title
        self.comments = comments
    }
}
