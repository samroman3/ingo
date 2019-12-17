//
//  Post.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/12/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct Post {
    let body: String
    let id: String
    let creatorID: String
    let lat: Double
    let long: Double
    let neighborhood: String
    let likes: Int
    let dislikes: Int
    
    
    init(body: String, creatorID: String, lat: Double, long: Double, neighborhood: String, likes: Int, dislikes: Int) {

        self.body = body
        self.creatorID = creatorID
        self.id = UUID().description
        self.lat = lat
        self.long = long
        self.neighborhood = neighborhood
        self.likes = likes
        self.dislikes = dislikes
        
    }
    
    init?(from dict: [String: Any], id: String) {
       guard let body = dict["body"] as? String,
        let userID = dict["creatorID"] as? String,
        let lat = dict["lat"] as? Double,
        let long = dict["long"] as? Double,
        let neighborhood = dict["neighborhood"] as? String,
        let likes = dict["likes"] as? Int,
        let dislikes = dict["dislikes"] as? Int else { return nil }
        self.body = body
        self.creatorID = userID
        self.id = id
        self.lat = lat
        self.long = long
        self.neighborhood = neighborhood
        self.likes = likes
        self.dislikes = dislikes
    }
    
    var fieldsDict: [String: Any] {
        return [
            "body": self.body,
            "creatorID": self.creatorID,
            "lat": self.lat,
            "long": self.long,
            "neighborhood": self.neighborhood,
            "likes": self.likes,
            "dislikes": self.dislikes
        ]
    }
}
