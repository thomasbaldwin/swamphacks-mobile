//
//  User.swift
//  NewTextExchange
//
//  Created by Thomas Baldwin on 1/24/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import Foundation

public final class User: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    var id: Int?
    var facebookUID: String?
    var firstName: String?
    var lastName: String?
    var thumbnailPhotoURL: String?
    
    override init() {
        super.init()
    }
    
    public init?(representation: AnyObject) {
        super.init()
        self.id = representation.valueForKeyPath("id") as? Int
        self.id = representation.valueForKeyPath("facebook_UID") as? Int
        self.firstName = representation.valueForKeyPath("first_name") as? String
        self.lastName = representation.valueForKeyPath("last_name") as? String
        self.thumbnailPhotoURL = representation.valueForKeyPath("user_thumbnail_photo_URL") as? String
    }
    
    public static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [User] {
        var users: [User] = []
        
        if let dataRepresentation = representation as? [[String: AnyObject]] {
            for userRepresentation in dataRepresentation {
                if let user = User(representation: userRepresentation) {
                    users.append(user)
                }
            }
        }
        
        return users
    }
}