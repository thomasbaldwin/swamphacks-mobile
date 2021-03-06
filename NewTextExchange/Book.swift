//
//  Book.swift
//  NewTextExchange
//
//  Created by Eric Suarez on 1/23/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation

public final class Book: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    var id: Int?
    var title: String?
    var course: String?
    var price: Int?
    var thumbnailPhotoURL: String?
    var coverPhotoURL: String?
    var author: String?
    var isbn: String?
    var quality: Double?
    var creator: User?
    
    override init() {
        super.init()
    }
    
    public init?(representation: AnyObject) {
        super.init()
        
        self.id = representation.valueForKeyPath("id") as? Int
        self.title = representation.valueForKeyPath("title") as? String
        self.course = representation.valueForKeyPath("course") as? String
        self.price = representation.valueForKeyPath("price") as? Int
        self.thumbnailPhotoURL = representation.valueForKeyPath("book_thumbnail_photo_URL") as? String
        self.coverPhotoURL = representation.valueForKeyPath("cover_photo_URL") as? String
        self.author = representation.valueForKeyPath("author") as? String
        self.isbn = representation.valueForKeyPath("isbn") as? String
        self.quality = representation.valueForKeyPath("quality") as? Double
        
        if let creatorRepresentation = (representation.valueForKeyPath("creator") as? [String: AnyObject]) {
            if let creator = User(representation: creatorRepresentation) {
                self.creator = creator
            }
        }
    }
    
    public static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Book] {
        var books: [Book] = []
        
        if let dataRepresentation = representation as? [[String: AnyObject]] {
            for bookRepresentation in dataRepresentation {
                if let book = Book(representation: bookRepresentation) {
                    books.append(book)
                }
            }
        }
        
        return books
    }
}