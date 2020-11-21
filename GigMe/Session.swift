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
    static let shared = Session()
    
    @Published var results:[Tweet]? = nil
    
    func getTweetsByText(text:String){
        
        //load tweets based off of raw text
        
        loadTweetsForString(text: text) { (tweets, err) in
            if let err = err{
                print(err)
            }
            if let tweets = tweets{
                if(self.results != nil){
                    //For each tweet, If results do not contain this tweet
                    self.results!.append(contentsOf:tweets.filter({tweet in !self.resultsContainsTweet(tweet: tweet)}))
                }
                else{
                    self.results = tweets
                }
            }
        }
        
        //Query each individual word
        
        let split = text.lowercased().split(separator: " ").map({String($0)})
        for word in split{
            //load based on individual words
            loadTweetsForString(text: text) { (tweets, err) in
                if let err = err{
                    print(err)
                }
                if let tweets = tweets{
                    if(self.results != nil){
                        //For each tweet, If results do not contain this tweet
                        self.results!.append(contentsOf:tweets.filter({tweet in !self.resultsContainsTweet(tweet: tweet)}))
                    }
                    else{
                        self.results = tweets
                    }
                }
            }
        }
        
        //Query based on top 3 categories
        
        let categories = Categories.getSimilarCategories(text: text)
        for category in categories{
            //load for hashtags
            loadTweetsForHashtags(hashtags: category.keywords) { (tweets, err) in
                if let err = err{
                    print(err)
                }
                if let tweets = tweets{
                    //For each tweet, If results do not contain this tweet
                    if(self.results != nil){
                        self.results!.append(contentsOf:tweets.filter({tweet in !self.resultsContainsTweet(tweet: tweet)}))
                    }
                    else{
                        self.results = tweets
                    }
                }
            }
        }
        
    }
    
    func clearResults(){
        self.results = nil
    }
    
    private func loadTweetsForString(text:String,completionHandler:@escaping([Tweet]?,Error?)->Void){
        //Main Query -> Should query for tweets (gigs) that contain text similar to the text input
        
        //NOTE: if you are unfamiliar with completion handlers when the results is found simply call the paramter and list the results as below
        DispatchQueue.main.async {
            completionHandler([],nil)
        }
    }
    
    private func loadTweetsForHashtags(hashtags:[String],completionHandler:@escaping([Tweet]?,Error?)->Void){
        //Main Query -> Should query for tweets that contain 1 or more of the hashtags input, this search should always contain #gigme
        
        //NOTE: if you are unfamiliar with completion handlers when the results is found simply call the paramter as below
        DispatchQueue.main.async {
            completionHandler([],nil)
        }
    }
    
    private func resultsContainsTweet(tweet:Tweet)->Bool{
        if let results = self.results{
            return results.contains(where: {$0.tweetID == tweet.tweetID})
        }
        else{
            return false
        }
    }
    
    //ADD api and data retrieval objects here, views will use methods from this class to retrieve data
    
}

enum LoadErrors:Error{
    case networkConnection
}

class DummyData{
    
    static let tweet = Tweet(tweetID: "xxx", dateTime: "Today", text: "Building a website for my new shop, if you can build websites and are interested hit me up 😁", location: "London, United Kingdom", hashtags: ["#sofwaredeveloper","#webdev","#reactJS","#ecommerce"], authorID: "xxx", authorHandle: "notDiannaRoss", imageUrls: nil, videoUrls: nil)
    
}
