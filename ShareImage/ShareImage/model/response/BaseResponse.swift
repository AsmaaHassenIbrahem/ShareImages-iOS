//
//  BaseResponse.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation

struct BaseResponse :Codable {
    
    let isSuccess : Bool
    let message : String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "IsSuccessful"
        case message = "Message"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isSuccess, forKey: .isSuccess)
        try container.encode(message, forKey: .message)
    }
}

