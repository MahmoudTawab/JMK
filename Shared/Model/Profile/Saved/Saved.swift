//
//  Saved.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/12/2021.
//

import Foundation

class Saved {
    
   var Id : Int?
   var Name : String?
   var Detalis = [SavedDetalis]()
 
   init(dictionary:[String:Any]) {
   Id = dictionary["Id"] as? Int
   Name = dictionary["Name"] as? String
       
   for item in dictionary["Detalis"] as? [[String:Any]] ?? [[String:Any]()] {
   Detalis.append(SavedDetalis(dictionary: item))
   }
   }
}


class SavedDetalis {
    
   var Id : Int?
   var ProdectId : Int?
   var Path : String?
   var type : String?
 
   init(dictionary:[String:Any]) {
   Id = dictionary["Id"] as? Int
   ProdectId = dictionary["ProdectId"] as? Int
   Path = dictionary["Path"] as? String
    type = dictionary["type"] as? String
   }
}
