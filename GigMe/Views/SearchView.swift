//
//  SearchView.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var viewRouter:ViewRouter
    
    @State var searchText = ""
    @State var searched = ""
    
    @State var barHeight:CGFloat = UIScreen.main.bounds.height*0.4
    @State var results:[Tweet]? = nil
    
    var body: some View {
            VStack(spacing:0){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color("TwitterBlue"))
                        .animation(.spring())
                    VStack(alignment: .leading,spacing:10){
                        Spacer()
                        if(!searched.isEmpty){
                            Text("#gigme")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack(alignment:.leading){
                            if(searched.isEmpty){
                                HStack{
                                    TextField("Search categories, keywords, locations", text: $searchText, onEditingChanged: {_ in}, onCommit: {commit(text: self.searchText)})
                                        .font(.system(size: 15, weight: .light))
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                                        
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                }
                            }
                            else{
                                HStack{
                                    Text(searched)
                                        .font(.system(size: 15, weight: .light))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Button(action:{clearSearch()}){
                                        Image(systemName: "xmark")
                                    }
                                }
                            }
                            Rectangle()
                                .frame(height:1)
                                .padding(.vertical,5)
                        }
                        .padding(.top,20)
                        if(results == nil && searchText.isEmpty){
                            Text("#gigme")
                                .font(.headline)
                                .fontWeight(.bold)
                            VStack(alignment:.leading){
                                Text("The gig is up.")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("Literally")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            .padding(.top)
                            Text("Find your next big break from over 1,000,000 gigs on Twitter 🙌")
                                .font(.headline)
                                .fontWeight(.light)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        }
                        if(results == nil && searched.isEmpty && !searchText.isEmpty){
                            VStack(alignment: .leading){
                                Text("I am a ...")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom,5)
                                
                                Text("Search for who you are, what you can do or the type of role you want 👓")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .padding(.bottom,5)
                                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                
                                //Replace with Flexbox View
                                HStack{
                                    Button(action:{self.commit(text: "software developer")}){
                                    Text("software developer")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .underline()
                                    }
                                    Button(action:{self.commit(text: "video developer")}){
                                    Text("video developer")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .underline()
                                    }
                                }
                                HStack{
                                    Button(action:{self.commit(text: "interior designer")}){
                                        Text("interior designer")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .underline()
                                    }
                                    Button(action:{self.commit(text: "video editor")}){
                                        Text("video editor")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        .underline()
                                    }
                                    Button(action:{self.commit(text: "tutor")}){
                                        Text("tutor")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .underline()
                                    }
                                }
                                Button(action:{self.viewRouter.presentModal(content: AnyView(CategoryView(searchText: self.$searchText, commit: commit)))}){
                                    Text("See More Categories")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .underline()
                                        .padding(.top)
                                }
                            }
                            .padding(.top,10)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width:UIScreen.main.bounds.width)
                    if(results == nil && searchText.isEmpty){
                        VStack{
                            Spacer()
                            Button(action:{self.viewRouter.presentModal(content: AnyView(GigMeGuide()))}){
                                Capsule()
                                    .foregroundColor(.white)
                                    .frame(width:120,height:40)
                                    .shadow(radius: 5)
                                    .overlay(Text("Learn More").font(.caption).fontWeight(.thin))
                                    .offset(y:20)
                                    
                            }
                        }
                    }
                    if(!searched.isEmpty){
                        VStack{
                            Spacer()
                            HStack(spacing:40){
                            
                                Button(action:{self.viewRouter.presentModal(content: AnyView(Text("Proof of Concept")))}){
                                    Capsule()
                                        .foregroundColor(.white)
                                        .frame(width:120,height:40)
                                        .shadow(radius: 5)
                                        .overlay(Text("Filter").font(.caption).fontWeight(.thin))
                                        .offset(y:20)
                                        
                                }
                                
                                Button(action:{self.viewRouter.presentModal(content: AnyView(Text("Sort By")))}){
                                    Capsule()
                                        .foregroundColor(.white)
                                        .frame(width:120,height:40)
                                        .shadow(radius: 5)
                                        .overlay(Text("Sort By").font(.caption).fontWeight(.thin))
                                        .offset(y:20)
                                        
                                }
                            }
                        }
                    }
                }
                .frame(height:self.barHeight)
                
                if(results == nil && searchText.isEmpty){
                    MainSubView()
                        .onAppear{
                            self.barHeight = UIScreen.main.bounds.width*0.85
                        }
                }
                
                else if(!self.searched.isEmpty){
                    SearchResultsView(searched: $searched, results: $results)
                        .onAppear{
                            self.barHeight = UIScreen.main.bounds.width*0.5
                        }
                }
                else if(results == nil){
                    SearchIndexView(searchText: $searchText, commit: commit)
                    .onAppear{
                        self.barHeight = UIScreen.main.bounds.width*0.8
                    }
                        .padding(.top)
                }
                else{
                    Text("edge case")
                        .onAppear{
                            self.clearSearch()
                        }
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .onReceive(Session.shared.$results, perform: { tweets in
                self.results = tweets
            })
    }
    
    func canCommit() -> Bool{
        if(self.searched.isEmpty && !self.searchText.isEmpty && self.results == nil){
            return true
        }
        else{
            return false
        }
    }
    
    func commit(text:String){
        //Fill a query list an iterate through it -> E.G: keyword, developer, run it though get category func, get a category, and then query every keyword in that category, insert order: searchField query first then keyword queries
        
        if(canCommit()){
            self.searched = text
            Session.shared.getTweetsByText(text: text)
        }
    }
    
    func clearSearch(){
        self.searched.removeAll()
        self.searchText.removeAll()
        Session.shared.clearResults()
    }
    
    struct GigTweetView:View{
        @EnvironmentObject var viewRouter:ViewRouter
        
        let tweet:Tweet
        var results:[Tweet]
        
        var body: some View{
            Button(action:{
                self.viewRouter.dismissModal()
                self.viewRouter.presentModal(content: AnyView(ResultDetailView(tweet: tweet, results: results)))
            }){
                VStack(alignment:.leading,spacing:10){
                    Text(tweet.category?.categoryName ?? (tweet.hashtags.count > 0 ? tweet.hashtags[0] : "Relevant Gig"))
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\"\(tweet.text)\"")
                        .font(.headline)
                        .fontWeight(.light)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    HStack{
                        Text(metaData(dateTime: tweet.dateTime, location: tweet.location))
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                        Spacer()
                        VStack{
                            //Spacer()
                            Text("@\(tweet.authorHandle)")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(Color("TwitterBlue"))
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        func metaData(dateTime:String,location:String?) -> String{
            
            var meta = ""
            
            meta.append(dateTime)
            if let loc = location{
                meta.append(" | \(loc)")
            }
            
            return meta
        }
    }
    
    struct MainSubView:View{
        
        @State var suggestedTweets:[Tweet]? = []
        @State var count = 1
        
        var body : some View{
            VStack(alignment:.leading){
                ScrollView{
                    VStack(alignment: .leading,spacing:10){
                        Text("Your Daily Tip 🤩")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        
                        Text("The more media, the better! Tweet your projects with a few good quality pictures and videos of your work to help people instantly understand your ability.")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    .padding()
                    Button(action:{}){
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .padding()
                                .shadow(radius: 5)
                            
                            VStack(spacing:15){
                                Text("Try our Gig Builder!")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Yes, we know this page is for finding gigs not creating them, but it's cool, trust me 😉")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                        .frame(height:150)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("We thought you might be interested in... ")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding()

                    HStack{
                        Spacer()
                    }
                    VStack(spacing:20){
                        ForEach(suggestedTweets ?? [],id: \.tweetID){tweet in
                            GigTweetView(tweet: tweet, results: suggestedTweets ?? [])
                                .padding(.horizontal)
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(height:0.5)
                        }
                    }
                }
            }
            .padding(.top,40)
            .onAppear{
                self.getSuggestedTweets()
            }
        }
        
        func getSuggestedTweets(){
            self.suggestedTweets = [DummyData.tweet]
        }
        
    }
    
    struct SearchIndexView:View{
        
        @Binding var searchText:String
        
        let commit:(String) -> Void
        
        var body : some View{
            ScrollView{
                VStack(spacing:0){
                    indexView()
                }
                
            }
            //.animation(.spring())
            
        }
        
        func indexView() -> some View{
            
            let categories = Categories.getSimilarCategories(text: self.searchText)
            
            if(categories.count > 0){
                return
                AnyView(
                    ForEach(categories,id: \.categoryName){category in
                        Button(action:{commit(category.categoryName)}){
                            VStack(alignment: .leading,spacing:5){
                                Text("\(category.categoryName)")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .padding(.horizontal)
                                HStack{
                                    Text("\(category.keywords.map({String("#"+$0)}).joined(separator: ", "))")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                                Rectangle()
                                    .frame(height:0.5)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top,20)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                )
            }
            else{
                return
                AnyView(
                    VStack(spacing:20){
                        Text("Search Twitter for gigs related to \"\(self.searchText)\"?")
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .underline()
                            .onTapGesture {
                                self.commit(self.searchText)
                            }
                        
                        Text("Try using broader keywords ✨")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("TwitterBlue"))
                        Text("E.G: For an animation role 🎬, use words like \"animate\" \"animation\" \"animator\" \"video\" \"edit\" \"cartoon\" \"Final Cut Pro\" \"cut\"")
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            
                        HStack{
                            Spacer()
                        }
                    }
                    .padding()
                )
            }
        }
    }
    
    struct SearchResultsView:View{
        
        @Binding var searched:String
        @Binding var results:[Tweet]?
        
        var body : some View{
            if(results != nil){
                VStack{
                    HStack{
                        if(results != nil){
                            HStack{
                                Text("\(results!.count) Displayed")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top,40)
                    .padding(.horizontal)
                    ScrollView{
                        if(self.results != nil){
                            if(!self.results!.isEmpty){
                                VStack(alignment:.leading,spacing:20){
                                    ForEach(results!,id: \.tweetID){tweet in
                                        GigTweetView(tweet: tweet, results: results ?? [])
                                            .padding(.horizontal)
                                        Rectangle()
                                            .foregroundColor(.gray)
                                            .frame(height:0.5)
                                    }
                                }
                            }
                            else{
                                //None Found
                                VStack{
                                    Text("No gigs found for \"\(self.searched)\"")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                }
                            }
                        }
                    }
                }
            }
            else{
                VStack{
                    //Add a timeout
                    Text("Loading...")
                    /*
                    Image(systemName: "loading")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:20,height:20)
                     */
                }
                .padding(.top,40)
            }
        }
    }
    
    struct GigMeGuide:View{
        
        var body : some View{
            ScrollView{
                VStack(alignment: .leading,spacing:20){
                    Text("Welcome to #gigme! 🥳")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    Text("Find gigs/projects from across Twitter that match your skillsets")
                        .font(.headline)
                        .fontWeight(.light)
                    Text("Follow us at @gigme for tips on how to maximise your skill search")
                        .font(.headline)
                        .fontWeight(.light)
                    VStack(alignment: .leading,spacing:30){
                        
                        VStack(alignment:.leading,spacing:10){
                            Text("What is a gig?")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("Anything you want it to be 🤩. If someone needs something created, designed, baked or shaked, we call that a gig. We call you producers, because you produce the talent they need.")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        
                        VStack(alignment:.leading,spacing:10){
                            Text("How do I find gigs?")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("Simply enter keywords relating to the type of role/gig your'e looking for and scroll until you find the gig of your dreams 🌈.")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        
                        VStack(alignment:.leading,spacing:10){
                            Text("How do I advertise gigs?")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("Tweet a brief description of the job you need done, add relevant keywords as hashtags and add #gigme. We'll handle the rest🤝")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        
                        VStack(alignment:.leading,spacing:10){
                            Text("Another job board?")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            VStack(alignment: .leading,spacing: 10){
                                HStack(spacing:0){
                                    Text("Yes but make it ")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    Text("different")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .italic()
                                    Text(" ✨.")
                                }
                                Text("Twitter is all about expression, use #gigme to be creative and express a more personal side to your story. Whether you need talent or you are talent, we believe in hiring people not positions.")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            }
                        }
                        
                        VStack(alignment:.leading,spacing:10){
                            Text("#gigpro Comiing Soon ‼️")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("#gigme allows those can supply to meet those who demand, #gigpro will allow those who demand to meet those who can supply . Start adding #gigpro to your projects and bio from now to start build your profile!")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        
                        HStack{
                            Text("#gigme @29milesb")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .padding()
            }
        }
        
    }
    
    struct CategoryView:View{
        
        @Binding var searchText:String
        
        let commit:(String)->Void
    
        @State var categories:[Category] = []

        var body : some View{
            VStack(alignment: .leading,spacing:0){
                VStack(alignment: .leading,spacing:10){
                    Text("Categories")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("A list of all categories from A-Z 🔎. Thats it, thats the tweet.")
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                .padding()
                
                ScrollView{
                    AnyView(
                        ForEach(categories.sorted(by: {$0.categoryName.lowercased() < $1.categoryName.lowercased()}),id: \.categoryName){category in
                            Button(action:{commit(category.categoryName)}){
                                VStack(alignment: .leading,spacing:5){
                                    Text("\(category.categoryName)")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .padding(.horizontal)
                                    HStack{
                                        Text("\(category.keywords.map({String("#"+$0)}).joined(separator: ", "))")
                                            .font(.caption)
                                            .fontWeight(.light)
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    Rectangle()
                                        .frame(height:0.5)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top,20)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    )
                }
                
                Spacer()
                HStack{
                    Spacer()
                }
            }
            .onAppear{
                self.categories = Categories.categories
            }
        }
        
    }
    
    struct ResultDetailView:View{
        
        let tweet:Tweet
        
        let results:[Tweet]
        
        var body : some View{
            ScrollView{
                VStack{
                    VStack(spacing:30){
                        HStack(spacing: 10){
                            UrlImage(urlString: tweet.authorProfileUrl, width: 50, height: 50, contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width:50,height:50)
                            Text("@\(tweet.authorHandle)")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(Color("TwitterBlue"))
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        Text("\"\(tweet.text)\"")
                            .font(.title)
                            .fontWeight(.light)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach((tweet.imageUrls ?? []),id: \.self){url in
                                    UrlImage(urlString: url, height: 100, contentMode: .fit,def:"defaultimage")
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .frame(height:100)
                                }
                                Spacer()
                            }
                        }
                        
                        HStack{
                            Text("\(tweet.hashtags.map({String("#"+$0)}).joined(separator: ", "))")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        
                        HStack{
                            Button(action:{self.openTwitter(handle: tweet.authorHandle)}){
                                Capsule()
                                    .foregroundColor(Color("TwitterBlue"))
                                    .frame(width:190,height:60)
                                    .overlay(
                                        HStack{
                                            Text("Go to Twitter")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Image("twitter")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 20)
                                        }
                                        .padding(20)
                                    )
                            }
                            Spacer()
                        }
                        
                        HStack{
                            VStack(alignment: .leading,spacing:10){
                                
                                Text("\(tweet.category?.categoryName ?? (tweet.hashtags.count > 0 ? tweet.hashtags[0] : "Relevant Gig"))")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                HStack{
                                    Text(metaData(dateTime: tweet.dateTime, location: tweet.location))
                                        .font(.headline)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)

                                    Spacer()
                                    
                                }
                            }
                            Spacer()
                        }

                    }
                    .padding()
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height:0.5)
                    
                    if(filteredResults().count > 0){
                        VStack(alignment:.leading){
                            Text("If you liked this gig, you might like...")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)

                            HStack{
                                Spacer()
                            }
                            VStack(spacing:20){
                                ForEach(filteredResults(),id: \.tweetID){tweet in
                                    GigTweetView(tweet: tweet, results: results)
                                        .padding(.horizontal)
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .frame(height:0.5)
                                }
                            }
                        }
                        .padding(.top)
                    }
                    Spacer()
                }
                HStack{
                    Text("#gigme @29milesb")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
            }
        }
        
        func metaData(dateTime:String,location:String?) -> String{
            
            var meta = ""
            
            meta.append(dateTime)
            if let loc = location{
                meta.append(" | \(loc)")
            }
            
            return meta
        }
        
        func filteredResults() -> [Tweet]{
            return results.filter({$0.tweetID != tweet.tweetID})
        }
        
        func openTwitter(handle:String){
            let screenName =  handle
               let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
               let webURL = NSURL(string: "https://twitter.com/\(screenName)")!

               let application = UIApplication.shared

               if application.canOpenURL(appURL as URL) {
                    application.open(appURL as URL)
               } else {
                    application.open(webURL as URL)
               }
        }
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
