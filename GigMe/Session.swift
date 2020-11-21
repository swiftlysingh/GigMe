//
//  Session.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import Foundation
import UIKit
import SwiftUI

class Session{
    
    //singleton -> object accessible from anywhere within the project
    let session = Session()
    
    
    //ADD api and data retrieval objects here, views will use methods from this class to retrieve data
    
}

class DummyData{
    
    static let tweet = Tweet(tweetID: "xxx", dateTime: "Today", text: "Building a website for my new shop, if you can build websites and are interested hit me up 😁", location: "London, United Kingdom", hashtags: ["#sofwaredeveloper","#webdev","#reactJS","#ecommerce"], authorID: "xxx", authorHandle: "notDiannaRoss", imageUrls: nil, videoUrls: nil)
    
}
