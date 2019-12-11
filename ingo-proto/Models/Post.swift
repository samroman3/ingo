//
//  Post.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/12/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct Post {
    let title: String?
    let body: String
    let id: String
    let creatorID: String
    let text: String?
    let image: Data?
    let lat: Double
    let long: Double
    
    
    init(title: String, body: String, creatorID: String, text: String?, image: Data?, lat: Double, long: Double) {
        self.title = title
        self.body = body
        self.creatorID = creatorID
        self.id = UUID().description
        self.text = text
        self.image = image
        self.lat = lat
        self.long = long
        
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let title = dict["title"] as? String,
            let body = dict["body"] as? String,
            let userID = dict["creatorID"] as? String,
            let text = dict["text"] as? String,
            let image = dict["image"] as? Data,
        let lat = dict["lat"] as? Double,
        let long = dict["long"] as? Double else {
                return nil
        }
        self.title = title
        self.body = body
        self.creatorID = userID
        self.id = id
        self.text = text
        self.image = image
        self.lat = lat
        self.long = long

    }
    
    var fieldsDict: [String: Any] {
        return [
            "title": self.title,
            "body": self.body,
            "creatorID": self.creatorID,
            "text": self.text,
            "image": self.image,
            "lat": self.lat,
            "long": self.long
        ]
    }
}
