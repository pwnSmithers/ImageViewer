//
//  MainCollectionViewController.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
import UIKit

class MainCollectionViewController: UICollectionViewController {

    lazy var mainSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Photos, people, or groups"
        return searchBar
    }()
    
    let flickrLabel : UILabel = {
        let label = UILabel()
        label.text = "Flickr"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellIdentifier = "cellIdentifier"
    let headerCellIdentifier = "headerCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView(){
        collectionView.backgroundColor = .white
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        
        collectionView.addSubview(mainSearchBar)
        collectionView.addConstraints([
            mainSearchBar.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 2),
            mainSearchBar.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 2),
            mainSearchBar.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 2),
            mainSearchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        return imageCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellIdentifier, for: indexPath)
        header.addSubview(flickrLabel)
        header.addSubview(mainSearchBar)
        
        flickrLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 2).isActive = true
        flickrLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        flickrLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        flickrLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        mainSearchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        mainSearchBar.topAnchor.constraint(equalTo: flickrLabel.bottomAnchor).isActive = true
        mainSearchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
      return header
    }
    
}


extension MainCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    
}
