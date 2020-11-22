//
//  Response.swift
//  GigMe
//
//  Created by PRABALJIT WALIA     on 21/11/20.
//

import Foundation
struct Response:Decodable{
    var items = [Tweet]()
    enum CodingKeys:String,CodingKey{
        
        case items
        
    }
    init(from decoder:Decoder) throws {
          
          let container = try decoder.container(keyedBy: CodingKeys.self)
          
          self.items = try container.decode([Tweet].self, forKey: .items)
//        print(items)
        print(items[0].text)
      }
    
    
}
