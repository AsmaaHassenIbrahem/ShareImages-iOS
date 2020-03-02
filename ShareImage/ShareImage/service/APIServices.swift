//
//  APIServices.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import Moya

enum APIServices {
    case loginUser(username : String)
    case uploadImage(image : UIImage ,userId : Int, isPublic :Bool)
    case readData(userId : Int)
}

extension APIServices :TargetType {
    var baseURL: URL {
        return URL(string:"http://api.potatohutkw.com/api/home")!
    }
    
    var path: String {
        switch self {
        case .loginUser(_):
            return "/Login"
        case .uploadImage(_, _, _):
            return "/AddPost"
        case .readData( _) :
            return "/getPosts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginUser(_) , .uploadImage(_, _ ,_):
            return .post
        case .readData(_):
            return .get
        }
    }
    
    var sampleData: Data {
        
        switch self {
        case .loginUser(_) , .uploadImage(_,_, _) , .readData(_):
            return "{'username'}".data(using: String.Encoding.utf8)!
        }
    }
    var task: Task {
        switch self {
        case .loginUser(let username) :
            return .requestParameters(parameters: ["UserName": username ], encoding: JSONEncoding.default)
            
        case  .uploadImage(let image,let userID, let isPrivate):
            let convert = ConvertImageToBase64.convertImageToBase64(image: image)
            
            return .requestParameters(parameters: ["UserID": userID, "Picture" :convert , "Privacy":isPrivate ], encoding: JSONEncoding.default)
            
        case .readData(let userId):
            return .requestParameters(parameters: ["UserID" : userId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}

