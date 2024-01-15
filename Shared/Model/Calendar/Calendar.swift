//
//  Calendar.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/12/2021.
//

import Foundation

class Calendar {
    
   var Id : Int?
   var Title : String?
   var Description : String?
   var Date : String?
 
    
    init(dictionary:[String:Any]) {
       
    Id = dictionary["Id"] as? Int
    Title = dictionary["Title"] as? String
    Description = dictionary["Description"] as? String
    Date = dictionary["Date"] as? String
    }
}
