//
//  ImageViewerTests.swift
//  ImageViewerTests
//
//  Created by Smithers on 04/11/2019.
//  Copyright © 2019 Smithers. All rights reserved.
//

import XCTest
@testable import ImageViewer

class ImageViewerTests: XCTestCase {
    
    var photos : Image?
    
    override func setUp() {
        super.setUp()
        self.photos = Image(id: "20081", title: "Hello this is an awesome image", owner: "2781265", farm: 76, server: "097524", secret: "2187634")
    }

    override func tearDown() {
        self.photos = nil
        super.tearDown()
    }

    func testViewModel() {
        guard let image = photos else{return}
        let viewModel = PhotosViewModel(model: image)
        XCTAssertNotNil(viewModel)
        
        XCTAssertEqual(viewModel.id, "20081")
        XCTAssertEqual(viewModel.title, "Hello this is an awesome image")
        XCTAssertEqual(viewModel.owner, "2781265")
        XCTAssertEqual(viewModel.farm, 76)
        XCTAssertEqual(viewModel.server, "097524")
        XCTAssertEqual(viewModel.secret, "2187634")
    }
    
    func testUrlGenerator() {
        guard let image = photos else{return}
        //test if generated URl is equal to expected URL
        let photoUrl = CreateFlikrPhotoApiUrl(farm: String(image.farm), server: image.server, id: image.id, secret: image.secret)
        let finalUrl = photoUrl.flickrPhotoUrlConstructor()
        print(finalUrl)
        let expectedURL = URL(string: "https://farm76.staticflickr.com/097524/20081_2187634.jpg")
        XCTAssertEqual(finalUrl, expectedURL)
    }
}
