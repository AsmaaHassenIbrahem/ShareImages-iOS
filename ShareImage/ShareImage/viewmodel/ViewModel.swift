//
//  ViewModel.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit
import Moya

class ViewModel: NSObject {
    
    var apiProvider : MoyaProvider<APIServices>
    
    init(apiProvider: MoyaProvider<APIServices> = MoyaProvider<APIServices>()) {
        self.apiProvider = apiProvider
    }
    func login(username :String ,completion: @escaping(Int?, Error?)->()){
        
        apiProvider.request(.loginUser(username: username), completion: {(Result) in
            switch Result {
            case .success(let response):
                do {
                    let user = try response.map(LoginResponse.self)
                    print(user.result.userId)
                    completion(user.result.userId , nil)
                }
                catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
                
            }
            
        })
    }
    
    func upload(image :UIImage ,userId :Int , isPublic:Bool , completion: @escaping(Bool)->()){
        
        apiProvider.request(.uploadImage(image: image, userId: userId, isPublic: isPublic), completion: {(Result) in
            switch Result {
            case .success(let response):
                do {
                    let result = try response.map(BaseResponse.self)
                    completion(result.isSuccess)
                    print(result.isSuccess)
                }
                catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error.errorDescription)
                
            }
            
        })
    }
    
    func getImagesVal(userId :Int , completion: @escaping(ImageListResponse, Error?)->()){
        
        apiProvider.request(.readData(userId: userId), completion: {(Result) in
            switch Result {
            case .success(let response):
                do {
                    let images = try response.map(ImageListResponse.self)
                    print(images.result[0].picture)
                    completion(images , nil)
                }
                catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
                
            }
            
        })
    }
}

