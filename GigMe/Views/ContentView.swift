//
//  ContentView.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import SwiftUI
import Swifter

struct ContentView: View {
    
    @EnvironmentObject var viewRouter:ViewRouter
    @State var viewDisplayed:Views = Views.searchView
    
    @State var modalPresented:Bool = false
    
    var body: some View {
            
        VStack(spacing:0){
            if(viewDisplayed == Views.searchView){
                SearchView()
            }
            else if(viewDisplayed == Views.profileView){
                ProfileView()
            }
            else{
                Text("Should never be here")
            }
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .shadow(radius: 5)
                VStack(spacing:0){
                    HStack(spacing:0){
                        Spacer()
                        getTabIcon(name: "magnifyingglass", view: Views.searchView)
                            .padding(.trailing)
                        Spacer()
                        Button(action:{self.setView(view: Views.profileView)}){
                        Text("🕺")
                            .font(.system(size: 40))
                            .frame(width:40,height:40)
                            .animation(.easeInOut)
                                
                        }
                            .padding(.leading)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            .frame(height:100)

        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $modalPresented,onDismiss: {self.viewRouter.dismissModal()}, content: {viewRouter.modalContent})
        .onReceive(viewRouter.$view, perform: { view in
            self.viewDisplayed = view
        })
        .onReceive(viewRouter.$modalPresented, perform: { bool in
            self.modalPresented = bool
        })
        .onAppear{
            self.test()
        }
        
    }
    
    func test(){
        
        let key = "wL86dZOup1cepUtjudP2PSX2A"
        let scret_key = "ZivOBxiUzNTB4q8FIpQP6Q2HnCQHqP0Yet2zLIRXrhvz13wbTe"
        var swifter = Swifter(consumerKey: key, consumerSecret: scret_key)
        
        if let url = URL(string: "GigMe://Hello"){
            swifter.authorize(with: url, presentFrom: UIViewController()) { (token, response) in
                print("it worked")
            
                
            } failure: { (err) in
                print(err)
            }

        }
        
    }
    
    func getTabIcon(name:String,view:Views) -> some View{
        
        var color = Color.gray
        
        if(self.viewRouter.view == view){
            color = Color.black
        }
        
        return
        Button(action:{self.setView(view: view)}){
        Image(systemName: name)
            .resizable()
            .foregroundColor(color)
            .frame(width:40,height:40)
            .animation(.easeInOut)
                
        }
    }
    
    func setView(view:Views){
        self.viewRouter.view = view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}
