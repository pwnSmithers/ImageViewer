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

enum ApiCallType {
    case recent
    case search
}

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
    var photoArray = [Image]()
    var pageCount = 1
    var searchTerm : String?
    var apiCallType : ApiCallType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        //preload some images
        apiCallType = .recent
        loadImagesFromNetwork(callType: .recent(count: pageCount))
    }
    
    fileprivate func setupView(){
        collectionView.backgroundColor = .white

        
        mainSearchBar.delegate = self
        
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
    
    fileprivate func setupNavigationBar(){
        navigationItem.title = "Flickr"
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchTapped(sender:)))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func searchTapped(sender: UIBarButtonItem){
        if mainSearchBar.isHidden{
            mainSearchBar.isHidden = false
        }
        navigationItem.titleView = mainSearchBar
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSearch(sender:)))
        navigationItem.rightBarButtonItem = cancelBarButtonItem
    }
    
    @objc func cancelSearch(sender: UIBarButtonItem){
        setupNavigationBar()
        mainSearchBar.isHidden = true
    }
    
    fileprivate func loadImagesFromNetwork(callType: NetworkingService){
        networkingProvider.request(callType) { (result) in
                    switch result{
                    case .success(let response):
                        do{
                            let photoResults = try JSONDecoder().decode(Photos.self, from: response.data)
                            let imagesArray = photoResults.photos.photo
                            imagesArray.forEach {
                                self.photoArray.append($0)
                            }
                            print(self.photoArray)
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
    
    fileprivate func loadMoreImages(){
            pageCount += 1
            switch apiCallType {
                   case .recent:
                    loadImagesFromNetwork(callType: .recent(count: pageCount))
                   case .search:
                    if let search = searchTerm{
                       loadImagesFromNetwork(callType: .Search(term: search, count: pageCount))
                    }
                   case .none:
                       print("Nothing should happen")
            }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        guard !photoArray.isEmpty else{return imageCell}
        let viewModel = SearchViewModel(model: photoArray[indexPath.row])
                     DispatchQueue.main.async {
                         imageCell.titleLabel.text = viewModel.title
                          let photoUrl = "https://farm\(String(viewModel.farm)).staticflickr.com/\(viewModel.server)/\(viewModel.id)_\(viewModel.secret).jpg"
                         imageCell.imageView.kf.indicatorType = .activity
                         imageCell.imageView.kf.setImage(with: URL(string: photoUrl), placeholder: UIImage(named: "placeholder"))
                         imageCell.imageView.contentMode = .scaleToFill
                        imageCell.setCellShadow()
                     }
        return imageCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !photoArray.isEmpty else{return 3}
        return photoArray.count
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
        guard !photoArray.isEmpty else{return}
        let photo = photoArray[indexPath.row]
        let photoUrl = CreateFlikrApiUrl(farm: String(photo.farm), server: photo.server, id: photo.id, secret: photo.secret)
        let finalUrl = photoUrl.flickrPhotoUrlConstructor()
        let fullImageController = FullImageViewController(photoUrl: finalUrl)
        self.navigationController?.pushViewController(fullImageController, animated: true)
        
    }
    
    //to load more images when all preloaded ones have been loaded and displayed
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !photoArray.isEmpty else{return}
        let imageArrayCount = photoArray.count
        if indexPath.row == imageArrayCount - 3 {
            loadMoreImages()
        }
    }
    
    
}

extension MainCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

extension MainCollectionViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            //save searchTerm to be used globally
            searchTerm = searchText
            //reset array and page count
            photoArray.removeAll()
            pageCount = 0
            apiCallType = .search
            loadImagesFromNetwork(callType: .Search(term: searchText, count: 1))
            searchBar.resignFirstResponder()
        }
    }
    
}
