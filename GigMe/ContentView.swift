//
//  ContentView.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewRouter:ViewRouter
    @State var viewDisplayed:Views = Views.searchView
    
    var body: some View {
        ZStack{
            VStack{
                if(viewDisplayed == Views.searchView){
                    SearchView()
                }
                else{
                    Text("Should never be here")
                }
            }
        }
        .onReceive(viewRouter.$view, perform: { view in
            self.viewDisplayed = view
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
