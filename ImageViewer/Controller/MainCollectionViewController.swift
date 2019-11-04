//
//  MainCollectionViewController.swift
//  ImageViewer
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import Foundation
import UIKit
import Moya

class MainCollectionViewController: UICollectionViewController {

    lazy var mainSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Photos, people, or groups"
        return searchBar
    }()

    let cellIdentifier = "cellIdentifier"
    let headerCellIdentifier = "headerCellIdentifier"
    let networkingProvider = MoyaProvider<NetworkingService>()
    var photosArray : Photos?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        search(for: "Uganda")
    }
    
    fileprivate func setupView(){
        collectionView.backgroundColor = .white
        navigationItem.title = "Flickr"
        
        navigationController?.navigationBar.tintColor = .black
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
    
    fileprivate func search(for term: String){
        networkingProvider.request(.Search(term: term)) { (result) in
            switch result{
            case .success(let response):
                do{
                    let searchResults = try JSONDecoder().decode(Photos.self, from: response.data)
                    self.photosArray = searchResults
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        photosArray?.photos.forEach({
            imageCell.titleLabel.text = $0.title
        })
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
        
        header.addSubview(mainSearchBar)
     
        mainSearchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        mainSearchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        mainSearchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
      return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullImageController = FullImageViewController()
        print("Cell\(indexPath) clicked")
        self.navigationController?.pushViewController(fullImageController, animated: true)
    }
    
}


extension MainCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
