//
//  Model.swift
//  SocialFeed
//
//  Created by Devesh Nema on 5/21/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import Foundation

class Post {
    var name : String?
    var date : String?
    var location : String?
    var likes : String?
    var comments : String?
    var imageName : String?
    var statusText : String?
    var statusImageName : String?
    
    init(name: String,
         imageName: String,
         statusText: String,
         date: String,
         location: String,
         statusImageName: String,
         likes: String,
         comments: String) {
        self.name = name
        self.imageName = imageName
        self.statusText = statusText
        self.date = date
        self.location = location
        self.statusImageName = statusImageName
        self.likes = likes
        self.comments = comments
    }
}
