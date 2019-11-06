                                  IMAGE VIEWER APPLICATION:
Image viewer application is a sample project i worked as part of the process of getting place, i was tasked with consuming the Flickr API (returned JSON), no authentication was required(Please see documentation with project specifications)

https://docs.google.com/document/d/19bR5Ak6uv7YjQ-EFGU_4IMK_U7t_plOetVCddQzMSSA/edit

ARCHITECTURE PATTERN USED:
Recently i had been playing around with different architectures i.e MVP and MVVM, i made the decision to go with MVVM because i was more familiar with this particular architecture.

UNIT TESTING:
I was able to write some tests using XCTest which can be found in the following file
ImageViewerTests.swift located in the ImageViewerTests Folder
I had also installed Quick + Nimble to carry out more Behavior driven Testing but the deadline for the project did not allow for this to happen.

THIRD PARTY LIBRARIES USED
I tried to keep the libraries as minimal as possible, only the necessary libraries where used especially for networking. The networking library used was chosen because it’s fully tested and has ongoing support.
Alamofire -  Networking
Moya - Network layer abstraction
KingFisher - Image downloading & Caching
Quick + Nimble - Behaviour driven testing

API:
Flickr API key used belongs to mugalu@bulamu.net, please reach out to him in case you need to reset it or move it to commercial. It’s currently for personal use.

Application flow:
--When you first launch the application , it’s the storyboard that is presented first
--The MainCollectionVIewController is then called, at first there are no Photos/Images to present, so it displays 3 cells with placeholders
--It’s at this point that a network request is made to the Flickr API to return Recent Images that have been posted to FLickr(25 images are returned everytime)
--If the network request is successful, the images are displayed into the collection view cells.
--A search button exists at the top, inside the navigation bar
--Once the user taps the search button, a search bar is presented to the user, prompting them to enter any term
--The user can either press Search or cancel
--If they press Cancel, it dismisses the keyboard and dismisses the search field too
--If they press search, a network call is made to the Flickr API requesting for images that match the search term.
--When results are returned, it should present display 25 returned results into the collection view cells.
--If a user taps on any of the cells, they transferred to another view
--This view is called FullImageViewController, it displays the image in full using .scaleAspectFit
-On the full image view, the user is presented with a back button, which if tapped returns them to the previous search results.



TO DO List:
I intend to implement behaviour driven testing with quick + nimble
Modularize the code a bit more(The main view controller is a bit congested)
Introduce some RxSwift(this is something I've been learning)
Provide more protection for the API Key, its currently unsafe
Introduce ability to switch between layouts i.e Staggered, list and Grid.


