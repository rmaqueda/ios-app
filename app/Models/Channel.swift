//
//  Channel.swift
//  app
//
//  Created by Максим Ефимов on 11.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import Foundation

class Channel {
    let url : String!
    let title : String!
    let imgUrl : String?
    
    init(url: String, title: String, imgUrl: String?){
        self.url = url
        self.title = title
        self.imgUrl = imgUrl
    }
}
