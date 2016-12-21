//
//  Article.swift
//  HustleCo
//
//  Created by Rodney Gainous Jr on 12/21/16.
//  Copyright © 2016 Rodney Gainous Jr. All rights reserved.
//

import Foundation

struct Article {
    var id: String
    var headline: String!
    var subtitle: String!
    var content: String!
    var writer: String!
    var writerImage: String
    var postedDate: Float!
    var imageName: String!
    
    init(json: NSDictionary) {
        id = ""
        headline = ""
        subtitle = ""
        content = ""
        writer = ""
        writerImage = ""
        postedDate = 0.0
        imageName = ""
    }
}
