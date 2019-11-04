//
//  FullImageViewController.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
import UIKit


class FullImageViewController: UIViewController {
    
    let fullImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bear")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(fullImageView)
        
        view.addConstraints([
            fullImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            fullImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            fullImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            fullImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
    }
}
