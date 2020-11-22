//
//  Session.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import Foundation
import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore

import Swifter


class Session{
    
    let swifter = Swifter(consumerKey: Secrets.key, consumerSecret:Secrets.key_secret
    )
    
    //singleton -> object accessible from anywhere within the project
    static let shared = Session()
    
    init(){
        
        //Test.test()
        
        //Load categories
        Firestore.firestore().collection("Categories").getDocuments() { (snapshot, err) in
            if let err = err{
                print(err)
            }
            if let snapshot = snapshot{
                for doc in snapshot.documents{
                    let dictionary = doc.data()
                    let name = dictionary[CategoryKey.name.rawValue] as! String?
                    //Team member understandably made some mistakes with data entry
                    let names = dictionary["names"] as! String?
                    let keywords = dictionary[CategoryKey.keywords.rawValue] as! NSArray? as! [String]?
                    
                    if let keywords = keywords{
                        if let names = names{
                            Categories.categories.append(Category(categoryName: names, keywords: keywords))
                        }
                        if let name = name{
                            Categories.categories.append(Category(categoryName: name, keywords: keywords))
                        }
                    }
                    
                    
                    
                }
            }
        }
        
    }
    
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
        
        let query : String = """
"paid%20work"%20"\(text.lowercased())"%20looking%20OR%20need%20-filter%3Areplies%20-filter%3Aretweets
"""
        
        print(query)
        
        swifter.searchTweet(using: query) { (tweets,status) in
            print("success")
            print(tweets)
        } failure: { (error) in
            print("error")
        }
        
        
        //NOTE: if you are unfamiliar with completion handlers when the results is found simply call the paramter and list the results as below
        DispatchQueue.main.async {
            completionHandler([],nil)
        }
    }
    
    private func loadTweetsForHashtags(hashtags:[String],completionHandler:@escaping([Tweet]?,Error?)->Void){
        //Main Query -> Should query for tweets that contain 1 or more of the hashtags input, this search should always contain #gigme
        
        var query : String = "%20"
        for hashtag in hashtags{
            query.append("\(hashtag)%20")
        }
        print(query)
        
        //NOTE: if you are unfamiliar with completion handlers when the results is found simply call the paramter as below
        DispatchQueue.main.async {
            completionHandler([DummyData.tweet],nil)
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
    
    static let tweet = Tweet(tweetID: "xxx", dateTime: "Today", text: "Building a website for my new shop, if you can build websites and are interested hit me up 😁", location: "London, United Kingdom", hashtags: ["sofwaredeveloper","webdev","reactJS","ecommerce"], authorID: "xxx", authorHandle: "29milesb", profileImageUrl: "https://img.redbull.com/images/c_crop,x_0,y_0,h_3335,w_2668/c_fill,w_860,h_1075/q_auto,f_auto/redbullcom/2020/8/27/jfuwclbld3r5ympxjwhc/saweetie-portrait-nails",imageUrls: ["https://zdnet1.cbsistatic.com/hub/i/r/2019/12/03/e356637b-183e-49e5-b5f3-9122be9fd18b/resize/1200x900/3a0c20f4c22749385fedb363379b6be1/istock-827896866.jpg"], videoUrls: nil)
    
}

class Test{
    
}
