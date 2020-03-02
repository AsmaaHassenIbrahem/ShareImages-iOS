//
//  LoginResponse.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation

struct LoginResponse : Codable {
    //  let baseResponse : BaseResponse
    let result : Results
    
    enum CodingKeys: String, CodingKey {
        //     case baseResponse = ""
        case result = "Result"
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //    try container.encode(baseResponse, forKey: .baseResponse)
        try container.encode(result, forKey: .result)
    }
}

struct Results : Codable {
    
    let userId : Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "UserID"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
    }
    
}
struct ImageRow : Codable {
    
    var picture : String
    var postOwner: String
    var userId : Int
    
    enum CodingKeys: String, CodingKey {
        case picture = "Picture"
        case postOwner = "PostOwner"
        case userId = "UserID"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(picture, forKey: .picture)
        try container.encode(postOwner, forKey: .postOwner)
        try container.encode(userId, forKey: .userId)
        
    }
    
    
}

struct ImageListResponse : Codable {
    
    let result : [ImageRow]
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(result, forKey: .result)
    }
    
}
