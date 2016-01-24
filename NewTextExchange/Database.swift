//
//  Database.swift
//  NewTextExchange
//
//  Created by Thomas Baldwin on 1/24/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

struct Database {
    static func getImageFromURL(URL: String) -> Promise<UIImage> {
        return Promise { fulfill, reject in
            Alamofire.request(.GET, URL)
                .responseImage { response in
                    switch response.result {
                    case .Success(let image):
                        fulfill(image)
                    case .Failure(let error):
                        print("getImageFromURL error")
                        reject(error)
                    }
            }
        }
    }
    
    static func getBooks() -> Promise<[Book]> {
        return Promise { fulfill,reject in
            Alamofire.request(Router.ReadBooks()).validate()
                .responseCollection { (response: Response<[Book], NSError>) in
                    switch response.result {
                    case .Success(let books):
                        fulfill(books)
                    case .Failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
    static func getBook(bookId: Int) -> Promise<Book> {
        return Promise { fulfill,reject in
            Alamofire.request(Router.ReadBook(bookId)).validate()
                .responseObject { (response: Response<Book, NSError>) in
                    switch response.result {
                    case .Success(let book):
                        fulfill(book)
                    case .Failure(let error):
                        reject(error)
                    }
            }
        }
    }
}