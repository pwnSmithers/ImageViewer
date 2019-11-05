//
//  Constants.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation

struct GlobalConstants {
    static let ApiKey = "073f547e067e953a932a6e64f59d5cd4"
    
}

struct CreateFlikrApiUrl {
    let farm : String
    let server : String
    let id : String
    let secret : String
      func flickrPhotoUrlConstructor() -> URL{
          return URL(string: "https://farm\(String(farm)).staticflickr.com/\(server)/\(id)_\(secret).jpg")!
      }
}
