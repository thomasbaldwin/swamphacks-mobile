//
//  Book.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation

class Book: NSObject {
    
    var title: String?
    var course: String?
    var price: Int?
    var coverImage: NSURL?
    
    init(title: String?, course: String?, price: Int?, coverImage: NSURL?) {
        self.title = title
        self.course = course
        self.price = price
        self.coverImage = coverImage
    }
    
}
