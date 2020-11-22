//
//  GigBuilder.swift
//  GigMe
//
//  Created by Miles Broomfield on 22/11/2020.
//

import SwiftUI

struct GigBuilder: View {
    
    @State var searchText:String = ""
    
    @State var hashtags:[String] =  ["gigme"]
    
    @State var textColor = Color.black
    
    var body: some View {
        VStack{
            VStack(alignment: .leading,spacing:30){
                Text("Gig Builder 🛠")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("We heard your silent screams, we answered. Search keywords and we'll build the hashtags you'd need for that post")
                    .font(.headline)
                    .fontWeight(.light)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing:10){
                    HStack{
                        TextField("Search keywords", text: $searchText)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                    }
                    Rectangle()
                        .frame(height:0.5)
                }
            
            //Search Bar
            //Content/Build Window
                VStack(alignment:.leading,spacing: 20){
                    HStack{
                        hashtagString()
                        

                        Spacer()
                    }
                    .frame(maxHeight:150)
                    
                    Text("Tap to copy the hashtags, then go to twitter and start sharing your opportinty with the world ✨")
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button(action:{self.clearHashtags()}){
                        Text("Clear")
                            .underline()
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                    
                }
            //.padding(.vertical,30)

            //Twitter Button
                Button(action:{self.openTwitter()}){
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
                .padding(.vertical)
            }
            .padding()
            Spacer()
            
            //Categories
            
            ScrollView{
                ForEach(Categories.getSimilarCategories(text: self.searchText),id: \.categoryName){category in
                    Button(action:{self.addCategoryTags(category: category)}){
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
            }
        }
        .padding(.top)
    }
    
    
    func clearHashtags(){
        hashtags.removeAll()
        hashtags.append("gigme")
    }
    
    func hashtagString() -> some View{
        self.textColor = Color.black
        return
        Text(hashtags.map({"#"+$0}).joined(separator: ", "))
            .bold()
            .font(.subheadline)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(textColor)
            .onTapGesture {
                self.copyHashtags()
            }
    }
    
    func openTwitter(){
       let appURL = NSURL(string: "twitter://home")!
       let webURL = NSURL(string: "https://twitter.com/home")!

       let application = UIApplication.shared

       if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
       } else {
            application.open(webURL as URL)
       }
    
        self.textColor = Color.black
    }
    
    func addCategoryTags(category:Category){
        for tag in category.keywords{
            hashtags.append(tag)
        }
        self.textColor = Color.black
    }
    
    func copyHashtags(){
        let pasteboard = UIPasteboard.general
        pasteboard.string = hashtags.map({"#"+$0}).joined(separator: ", ")
        //Some notification
        self.textColor = Color.green
    }
    
}

struct GigBuilder_Previews: PreviewProvider {
    static var previews: some View {
        GigBuilder()
    }
}
