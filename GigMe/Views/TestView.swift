//
//  TestView.swift
//  GigMe
//
//  Created by Miles Broomfield on 23/11/2020.
//

import SwiftUI
import Swifter

struct TestView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                let swifter = Swifter(consumerKey: Secrets.key, consumerSecret:Secrets.key_secret
                )
                swifter.searchTweet(using: "news") { (tweets,status) in
                    print("success")
                    
                    print(tweets[0]["text"])
                    print(tweets[0]["id_str"])
                    print(tweets[0]["created_at"])
                    print(tweets[0]["user"]["profile_image_url_https"])
                    print(tweets[0]["user"]["name"])
                    print(tweets[0]["user"]["id_str"])
                    print(tweets[0]["user"]["location"])
                    print(tweets[0]["user"]["entities"]["hashtags"])
                    
                    

                    
                } failure: { (error) in
                    print("error")
                }
            }
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
