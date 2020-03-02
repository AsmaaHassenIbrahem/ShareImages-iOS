//
//  APIServicesTest.swift
//  ShareImageTests
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import XCTest
@testable import ShareImage

import Moya

class APIServicesTest: XCTestCase {
    
    private var imageJson : Data!
    private var loginJson : Data!
    private var uploadJson: Data!
    var stubbingProvider : MoyaProvider<APIServices>!
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        
        let urlOfImageResponse = bundle.url(forResource: "ImageListResponse", withExtension: "json")
        let urlOfLoginResponse = bundle.url(forResource: "LoginResponse", withExtension: "json")
        let urlOfUploadResponse = bundle.url(forResource: "BaseResponse", withExtension: "json")
        
        loginJson = try! Data(contentsOf: urlOfLoginResponse!)
        
        imageJson = try! Data(contentsOf: urlOfImageResponse!)
        
        uploadJson = try! Data(contentsOf: urlOfUploadResponse!)
    }
    
    override func tearDown() {
    }
    
    func apiRequests() {
        
        let customEndpointClosure = { (target: APIServices) -> Endpoint in
            _ = MoyaProvider.defaultEndpointMapping(for: target)
            
            switch target {
            case .loginUser( _):
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(200 , self.loginJson) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
                
            case .uploadImage(_, _, _):
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(200 , self.uploadJson) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            case .readData(_):
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(200 , self.imageJson) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
            
        }
        
         stubbingProvider = MoyaProvider<APIServices>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }
}
