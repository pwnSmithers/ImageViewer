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
    case Search(term: String)
    case recent
}

extension NetworkingService: TargetType {

    var baseURL: URL {
        switch self {
        case .Search(let term):
            let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(GlobalConstants.ApiKey)&text=\(term)&format=json&nojsoncallback=1"
            let finalURL = url.replacingOccurrences(of: " ", with: "+")
            return URL(string: finalURL)!
            
        case .recent:
            let url = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(GlobalConstants.ApiKey)&per_page=10&page=1&format=json&nojsoncallback=1"
            let finalURL = url.replacingOccurrences(of: " ", with: "+")
            return URL(string: finalURL)!
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
