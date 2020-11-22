//
//  ProfileView.swift
//  GigMe
//
//  Created by Miles Broomfield on 22/11/2020.
//

import SwiftUI

struct ProfileView: View {
    
    
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing:20){
                Text("Coming Soon!")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                Text("#gigpro")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                VStack(alignment:.leading){
                    HStack(spacing:0){
                        Text("#gigme")
                            .bold()
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(" connected you to opportunities")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                    HStack{
                        Text("#gigpro")
                            .bold()
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("will connect opportunities to you")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Text("Add #gigpro to the projects/work/experiences you post to help us showcase your talent to the right audience🕺")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    
            }
            .edgesIgnoringSafeArea(.all)
            .frame(width:geo.size.width,height: geo.size.height)
            .background(Color("teal"))
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
