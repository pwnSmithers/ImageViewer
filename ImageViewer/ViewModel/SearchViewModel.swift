//
//  SearchViewModel.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation


struct SearchViewModel {
    let id : String
    let title: String
    
    init(model: Image) {
        let photoID = model.id
        self.id = photoID
        let photoTitle = model.title
        self.title = photoTitle
    }
}
