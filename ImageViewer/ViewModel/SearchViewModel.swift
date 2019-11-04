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
    
    init(model: Photo) {
        let id = String(model.id)
        self.id = id
        let title = model.title
        self.title = title
    }
}
