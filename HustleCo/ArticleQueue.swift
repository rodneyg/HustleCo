//
//  ArticleQueue.swift
//  HustleCo
//
//  Created by Rodney Gainous Jr on 12/21/16.
//  Copyright © 2016 Rodney Gainous Jr. All rights reserved.
//

import Foundation

struct ArticleQueue<Article> {
    fileprivate var elements = [Article]()
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    public mutating func enqueue(_ element: Article) {
        elements.append(element)
    }
    
    public mutating func dequeue() -> Article? {
        if elements.count < 1 {
            return nil
        } else {
            return elements.removeFirst()
        }
    }
    
    public func peek() -> Article? {
        return elements.first
    }
}
