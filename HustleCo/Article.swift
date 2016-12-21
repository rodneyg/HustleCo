//
//  Article.swift
//  HustleCo
//
//  Created by Rodney Gainous Jr on 12/21/16.
//  Copyright © 2016 Rodney Gainous Jr. All rights reserved.
//

import Foundation

struct Article {
    var headline: String!
    var subtitle: String!
    var content: String!
    var writer: String!
    var writerImage: String!
    var postedDate: String!
    var imageName: String!
    
    init(json: NSDictionary) {
        headline = json["headline"] as! String
        subtitle = json["subtitle"] as! String
        content = json["content"] as! String
        writer = json["writer"] as! String
        writerImage = json["writerImage"] as! String
        postedDate = json["postedDate"] as! String
        imageName = json["imageName"] as! String
    }
}
