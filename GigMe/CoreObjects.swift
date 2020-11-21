//
//  CoreObjects.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import Foundation

struct Tweet{
    
    let tweetID:String
    
    //Clean time from date and leave in string format
    let dateTime:String

    let text:String
    
    //Clean for City,Country
    let location:String?
    
    let hashtags:[String]
    
    let authorID:String
    
    let authorHandle:String
    
    let imageUrls:[String]?
    
    let videoUrls:[String]?
    
    //Categories will contain hashtag sets, 
    let category:Category?
    
    init(tweetID:String,dateTime:String,text:String,location:String? = nil,hashtags:[String],authorID:String,authorHandle:String,imageUrls:[String]? = nil,videoUrls:[String]? = nil){
        self.tweetID = tweetID
        self.dateTime = dateTime
        self.text = text
        self.location = location
        self.hashtags = hashtags
        self.authorID = authorID
        self.authorHandle = authorHandle
        self.imageUrls = imageUrls
        self.videoUrls = videoUrls
        self.category = Categories.getBestCategory(text: text, hashtags: hashtags)
    }
    
}

struct Categories{
    
    static let techEng = Category(categoryName: "Technology and Engineering", keywords: ["software","engineer","web","dev","react","js","c++","java","c","python","py","mobile","development","website","tech","computer", "build"])
    
    static let mechanic = Category(categoryName: "Utility and Technician", keywords: ["engineer","electrician","utility","plumber","pipes","lights","fix","house","handy","handyman","technician","tech"])
    
    static let categories:[Category] = [techEng,mechanic]
    
    static func getSimilarCategories(text:String) -> [Category]{
        
        var allCategories = self.categories
        
        var simCategories:[(Category,Double,Int)] = []
        
        for category in categories{
            //checked for the best cateory
            
            //will be divided by the number of keywords there were to calculate a match score
            var totalScore:Double = 0
            var wordsMatched:Int = 0
            
            for keyword in category.keywords{
                if(keyword.lowercased().contains(text.lowercased()) || text.lowercased().contains(keyword.lowercased())){
                    totalScore+=1
                }
                let split = text.split(separator: " ").map({String($0.lowercased())})
                if(split.contains(keyword)){
                    wordsMatched+=1
                }
            }
            let score = totalScore/Double(category.keywords.count)
            if(wordsMatched > 0 || score > 0){
                simCategories.append((category,score,wordsMatched))
            }
        }
        
        var wordsMatched:[(Category,Int)] = []
        var leftOver:[(Category,Double)] = []
        
        for tup in simCategories{
            if(tup.2 > 0){
                wordsMatched.append((tup.0,tup.2))
            }
            else{
                leftOver.append((tup.0,tup.1))
            }
        }
        
        var ready:[Category] = []
        ready.append(contentsOf: wordsMatched.sorted(by: {$0.1 > $1.1}).map({$0.0}))
        ready.append(contentsOf: leftOver.sorted(by: {$0.1 > $1.1}).map({$0.0}))
        
        return ready
        
    }
    
    static func getBestCategory(text:String,hashtags:[String]) -> Category?{
        
        print("called")
        
        var bestCategory:(Category,Double,Int) = (Category(categoryName: "Relevant Gig", keywords: []),0,0)
        
        for category in categories{
            //checked for the best cateory
            
            //will be divided by the number of keywords there were to calculate a match score
            var totalScore:Double = 0
            var wordsMatched:Int = 0
            
            for keyword in category.keywords{
                let hashtags = hashtags.map({$0.lowercased()})
                if(text.lowercased().contains(keyword.lowercased())){
                    totalScore+=1
                }
                else if(hashtags.contains(keyword.lowercased())){
                    //Does not check if hashtags contain keywords to reduce running time
                    totalScore+=1
                    wordsMatched+=1
                }
                let split = text.split(separator: " ").map({String($0)})
                if(split.contains(keyword)){
                    wordsMatched+=1
                }
            }
            let score = totalScore/Double(category.keywords.count)
            if(wordsMatched > bestCategory.2){
                bestCategory = (category,score,wordsMatched)
                print("found")
            }
            else{
                if(bestCategory.2 == 0 && score > bestCategory.1){
                    bestCategory = (category,score,wordsMatched)
                    print("found")
                }
                print("did not find")
            }
        }
        
        if(bestCategory.1 == 0 && bestCategory.2 == 0){
            return nil
        }
        else{
            return bestCategory.0
        }
    }
}


struct Category{
    let categoryName:String
    let keywords:[String]
}
