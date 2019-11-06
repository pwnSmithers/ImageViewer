IMAGE VIEWER APPLICATION:
Image viewer application is a sample project i worked as part of the process of getting place, i was tasked with consuming the Flickr API (returned JSON), no authentication was required(Please see documentation with project specifications)

https://docs.google.com/document/d/19bR5Ak6uv7YjQ-EFGU_4IMK_U7t_plOetVCddQzMSSA/edit

Architecture pattern used:
Recently i had been playing around with different architectures i.e MVP and MVVM, i made the decision to go with MVVM because i was more familiar with this particular architecture.

Unit Testing:
I was able to write some tests using XCTest which can be found in the following file
ImageViewerTests.swift located in the ImageViewerTests Folder
I had also installed Quick + Nimble to carry out more Behavior driven Testing but the deadline for the project did not allow for this to happen.

Third party libraries used:
I tried to keep the libraries as minimal as possible, only the necessary libraries where used especially for networking. The networking library used was chosen because it’s fully tested and has ongoing support.
Alamofire -  Networking
Moya - Network layer abstraction
KingFisher - Image downloading & Caching
Quick + Nimble - Behaviour driven testing




TO DO List:
I intend to implement behaviour driven testing with quick + nimble
Modularize the code a bit more(The main view controller is a bit congested)
Introduce some RxSwift(this is something I've been learning)
Provide more protection for the API Key, its currently unsafe
Introduce ability to switch between layouts i.e Staggered, list and Grid.


