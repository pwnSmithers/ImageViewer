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
import Kingfisher

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
        //preload some images
        loadImagesFromNetwork(count: 10, callType: .recent)
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
    
    
    fileprivate func loadImagesFromNetwork(count: Int, callType: NetworkingService){
        networkingProvider.request(callType) { (result) in
                    switch result{
                    case .success(let response):
                        do{
                            let photoResults = try JSONDecoder().decode(Photos.self, from: response.data)
                            self.photosArray = photoResults
                             
                            //reload collection view data once data is returned from server
                            self.collectionView.reloadData()
                        }catch let error{
                            print(error)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
//    fileprivate func loadRecentImages(){
//        networkingProvider.request(.recent) { (result) in
//               switch result{
//               case .success(let response):
//                   do{
//                       let searchResults = try JSONDecoder().decode(Photos.self, from: response.data)
//                       self.photosArray = searchResults
//
//                       //reload collection view data once data is returned from server
//                       self.collectionView.reloadData()
//                   }catch let error{
//                       print(error)
//                   }
//               case .failure(let error):
//                   print(error)
//
//               }
//           }
//    }
    
//    fileprivate func search(for term: String){
//        networkingProvider.request(.Search(term: term)) { (result) in
//            switch result{
//            case .success(let response):
//                do{
//                    let searchResults = try JSONDecoder().decode(Photos.self, from: response.data)
//                    self.photosArray = searchResults
//                    //reload collection view data once data is returned from server
//                    self.collectionView.reloadData()
//
//                }catch let error{
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//
//            }
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        let photoDetails = photosArray?.photos.photo[indexPath.row]
        if let photo = photoDetails {
            let viewModel = SearchViewModel(model: photo)
                 DispatchQueue.main.async {
                     imageCell.titleLabel.text = viewModel.title
                      let photoUrl = "https://farm\(String(viewModel.farm)).staticflickr.com/\(viewModel.server)/\(viewModel.id)_\(viewModel.secret).jpg"
                     imageCell.imageView.kf.indicatorType = .activity
                     imageCell.imageView.kf.setImage(with: URL(string: photoUrl), placeholder: UIImage(named: "placeholder"))
                     imageCell.imageView.contentMode = .scaleToFill
                    imageCell.setCellShadow()
                 }
        }
        return imageCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photoArray = photosArray?.photos.photo{
            return photoArray.count
        }else{
            return 3
        }
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
        let photoDetails = photosArray?.photos.photo[indexPath.row]

        if let photo = photoDetails{
            let photoUrl = CreateFlikrApi(farm: String(photo.farm), server: photo.server, id: photo.id, secret: photo.secret)
            let finalUrl = photoUrl.flickrPhotoUrlConstructor()
            let fullImageController = FullImageViewController(photoUrl: finalUrl)
            self.navigationController?.pushViewController(fullImageController, animated: true)
        }
    }
}

extension MainCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
