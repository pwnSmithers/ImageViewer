//
//  Photos.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation

struct Photos : Codable {
    let photos : Photo
}

struct Photo : Codable {
    let photo : [Image]
}

struct Image : Codable {
    let id : String
    let title: String
    let owner: String
    let farm: Int
    let server: String
    let secret: String
}
