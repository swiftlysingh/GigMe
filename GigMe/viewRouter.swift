//
//  ViewRouter.swift
//  GigMe
//
//  Created by Miles Broomfield on 21/11/2020.
//


import Foundation
import UIKit
import SwiftUI

class ViewRouter:ObservableObject{
    
    @Published var view = Views.searchView
    
    //Modal
    
    @Published var modalPresented = false
    @Published var modalContent:AnyView = AnyView(EmptyView())
    
    func presentModal(content:AnyView){
        self.modalContent = content
        self.modalPresented = true
    }
    
    func dismissModal(){
        self.modalPresented = false
        self.modalContent = AnyView(EmptyView())
    }
}

enum Views{
    case searchView
}
