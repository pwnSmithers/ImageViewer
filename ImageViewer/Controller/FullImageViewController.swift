//
//  FullImageViewController.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FullImageViewController: UIViewController {
    var photoUrl : URL?
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
    
    init(photoUrl: URL?) {
        self.photoUrl = photoUrl
        super.init(nibName: nil, bundle: nil)
        if let url = self.photoUrl{
            display(image: url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func display(image withURl: URL) {
        DispatchQueue.main.async {
          self.fullImageView.kf.indicatorType = .activity
           self.fullImageView.kf.setImage(with: withURl)
           }
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
