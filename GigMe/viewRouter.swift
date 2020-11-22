//
//  viewRouter.swift
//  GigMe
//
//  Created by Miles Broomfield on 20/11/2020.
//

import Foundation
import UIKit
import SwiftUI

class ViewRouter:ObservableObject{
    
    @Published var view = Views.searchView
    
}

enum Views{
    case searchView
}
