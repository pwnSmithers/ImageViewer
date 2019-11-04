//
//  Photos.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation

struct Photos : Codable {
    let photos : [Photo]
}

struct Photo : Codable {
    let id : Int
    let title : String
}
