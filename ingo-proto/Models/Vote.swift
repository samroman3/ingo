//
//  Vote.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/1/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//



//TODO: Find way to manage upvotes/likes and downvotes/dislikes and store info to post in firebase
import Foundation

struct Vote: Codable {
    var likes: Int?
    var dislikes: Int?
    
    
    
    
    init(likes: Int?, dislikes: Int?) {
        self.likes = likes
        self.dislikes = dislikes
    }
    
}

