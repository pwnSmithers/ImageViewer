//
//  Constants.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
// FIXME: - Find better ways to save this API, this isn't safe. Done this way due to time constraints.
struct GlobalConstants {
    static let ApiKey = "073f547e067e953a932a6e64f59d5cd4"
}

struct CreateFlikrPhotoApiUrl {
    let farm : String
    let server : String
    let id : String
    let secret : String
    
      func flickrPhotoUrlConstructor() -> URL{
          return URL(string: "https://farm\(String(farm)).staticflickr.com/\(server)/\(id)_\(secret).jpg")!
      }
}

struct CreateBaseURL{
    let ApiKey : String
    let count : Int
    let term : String?
    
    func flickrBaseURLConstructor() -> URL{
        if let searchTerm = term {
            let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(ApiKey)&text=\(searchTerm)&per_page=10&page=\(count)&format=json&nojsoncallback=1".replacingOccurrences(of: " ", with: "+")
            return URL(string:  urlString)!
        }else{
            let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(ApiKey)&per_page=10&page=\(count)&format=json&nojsoncallback=1".replacingOccurrences(of: " ", with: "+")
            return URL(string: urlString)!
        }
    }
}
