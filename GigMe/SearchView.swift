//
//  SearchView.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @State var searched = ""
    
    @State var barHeight:CGFloat = UIScreen.main.bounds.height*0.4
    @State var results:[String]? = nil
    
    var body: some View {
        VStack(spacing:0){
            ZStack{
                Rectangle()
                    .foregroundColor(Color("TwitterBlue"))
                    .animation(.spring())
                VStack(alignment: .leading,spacing:10){
                    Spacer()
                    VStack(alignment:.leading){
                        if(searched.isEmpty){
                            HStack{
                                TextField("Search categories, keywords, locations", text: $searchText, onEditingChanged: {_ in}, onCommit: {commit()})
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
                    if(results == nil && !searchText.isEmpty){
                        VStack(alignment: .leading){
                            Text("I am a ...")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom,5)
                            
                            //Replace with Flexbox View
                            HStack{
                                Button(action:{}){
                                Text("software developer")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .underline()
                                }
                                Button(action:{}){
                                Text("video developer")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .underline()
                                }
                            }
                            HStack{
                                Button(action:{}){
                                    Text("interior designer")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .underline()
                                }
                                Button(action:{}){
                                    Text("video editor")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    .underline()
                                }
                                Button(action:{}){
                                    Text("tutor")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .underline()
                                }
                            }
                            Button(action:{}){
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
                        Button(action:{}){
                            Capsule()
                                .foregroundColor(.white)
                                .frame(width:120,height:40)
                                .shadow(radius: 5)
                                .overlay(Text("Learn More").font(.caption).fontWeight(.thin))
                                .offset(y:20)
                                
                        }
                    }
                }
                if(results != nil){
                    VStack{
                        Spacer()
                        HStack(spacing:40){
                            Button(action:{}){
                                Capsule()
                                    .foregroundColor(.white)
                                    .frame(width:120,height:40)
                                    .shadow(radius: 5)
                                    .overlay(Text("Filter").font(.caption).fontWeight(.thin))
                                    .offset(y:20)
                                    
                            }
                            Button(action:{}){
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
                        self.barHeight = UIScreen.main.bounds.width*0.8
                    }
            }
            else if(results == nil){
                SearchIndexView()
                .onAppear{
                    self.barHeight = UIScreen.main.bounds.width*0.65
                }
                    .padding(.top)
                    
            }
            else if(!self.searched.isEmpty){
                SearchResultsView(results: $results)
                    .onAppear{
                        self.barHeight = UIScreen.main.bounds.width*0.4
                    }
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
        
        
    }
    
    func canCommit() -> Bool{
        if(self.searched.isEmpty && !self.searchText.isEmpty && self.results == nil){
            return true
        }
        else{
            return false
        }
    }
    
    func commit(){
        if(canCommit()){
            self.searched = self.searchText
            self.results = []
        }
    }
    
    func clearSearch(){
        self.searched.removeAll()
        self.searchText.removeAll()
        self.results = nil
    }
    
    struct GigTweetView:View{
        var body: some View{
            VStack(alignment:.leading,spacing:10){
                Text("Media and Film")
                    .font(.caption)
                    .fontWeight(.bold)
                Text("\"I need a camera man that can shoot in 4K, DM me if interested\"")
                    .font(.headline)
                    .fontWeight(.light)
                HStack{
                    Text("Today 13:22 | Oxford Circus, London, England")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("@MikeWazowski")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(Color("TwitterBlue"))
                }
            }
        }
    }
    
    struct MainSubView:View{
        
        var body : some View{
            VStack(alignment:.leading){
                Text("We thought you might be interested in...")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                HStack{
                    Spacer()
                }
                ScrollView{
                    VStack(spacing:20){
                        ForEach((0...3),id: \.self){_ in
                            GigTweetView()
                                .padding(.horizontal)
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(height:0.5)
                        }
                    }
                }
            }
            .padding(.top,40)
        }
        
    }
    
    struct SearchIndexView:View{
        
        var body : some View{
            ScrollView{
                VStack(spacing:0){
                    ForEach((0...3),id: \.self){_ in
                        Button(action:{}){
                            VStack(alignment: .leading,spacing:5){
                                Text("React Js")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .padding(.horizontal)
                                HStack{
                                    Text("#ReactJS, #webdev, #softwareengineer, #softwaredeveloper")
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
            .animation(.spring())
            
        }
    }
    
    struct SearchResultsView:View{
        
        @Binding var results:[String]?
        
        var body : some View{
            VStack(alignment:.leading){
                HStack{
                    if(results != nil){
                        Text("\(results!.count) Displayed")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                }
                .padding(.top,40)
                .padding([.horizontal,.bottom])
                ScrollView{
                    VStack(spacing:20){
                        ForEach((0...3),id: \.self){_ in
                            GigTweetView()
                                .padding(.horizontal)
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(height:0.5)
                        }
                    }
                }
            }
        }
    }
    
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
