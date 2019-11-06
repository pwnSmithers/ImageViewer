//
//  PhotosViewModel.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation


struct PhotosViewModel {
    let id : String
    let title: String
    let owner: String
    let farm: Int
    let server: String
    let secret: String
    
    init(model: Image) {
        let photoID = model.id
        self.id = photoID
        let photoTitle = model.title
        self.title = photoTitle
        let photoOwner = model.owner
        self.owner = photoOwner
        let photoFarm = model.farm
        self.farm = photoFarm
        let photoServer = model.server
        self.server = photoServer
        let photoSecret = model.secret
        self.secret = photoSecret
    }
}
