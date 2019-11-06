//
//  NetworkingService.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
import Moya

enum NetworkingService{
    case Search(term: String, count: Int)
    case recent(count: Int)
}

extension NetworkingService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .Search(let term, let count):
            let searchURL = CreateBaseURL(ApiKey: GlobalConstants.ApiKey, count: count, term: term)
            let finalSearchUrl = searchURL.flickrBaseURLConstructor()
            print(finalSearchUrl)
            return finalSearchUrl
        case .recent(let count):
            let recentURL = CreateBaseURL(ApiKey: GlobalConstants.ApiKey, count: count, term: nil)
            let finalRecentUrl = recentURL.flickrBaseURLConstructor()
            return finalRecentUrl
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .Search(let term):
            return "{'term':'\(term)'}".data(using: .utf8)!
        case .recent:
            return  "{'term':'\("recent")'}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["content-type":"application/json"]
    }
    
}
