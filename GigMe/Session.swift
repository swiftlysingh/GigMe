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
    
    @Published var results:[Tweet]? = nil
    
    func getTweetsByText(text:String){
        
        //load tweets based off of raw text
        loadTweetsForString(text: text) { (tweet, err) in
            if let err = err{
                print(err)
            }
            if let tweet = tweet{
                if(self.results != nil){
                    self.results!.append(contentsOf: tweet)
                }
                else{
                    self.results = tweet
                }
            }
        }
        
        let split = text
        //split text into words, for each word
        
        //Use text to find categories related to the search
        
        //load tweets based off of keywords found within top 3 categories
        
    }
    
    private func loadTweetsForString(text:String,completionHandler:@escaping([Tweet]?,Error?)->Void){
        //Main Query
    }
    
    func clearResults(){
        self.results = nil
    }
    
    //ADD api and data retrieval objects here, views will use methods from this class to retrieve data
    
}

class DummyData{
    
    static let tweet = Tweet(tweetID: "xxx", dateTime: "Today", text: "Building a website for my new shop, if you can build websites and are interested hit me up 😁", location: "London, United Kingdom", hashtags: ["#sofwaredeveloper","#webdev","#reactJS","#ecommerce"], authorID: "xxx", authorHandle: "notDiannaRoss", imageUrls: nil, videoUrls: nil)
    
}
