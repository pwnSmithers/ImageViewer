//
//  Extensions.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func setCellShadow(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 15
    }
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
