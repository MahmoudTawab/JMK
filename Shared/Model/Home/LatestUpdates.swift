//
//  LatestUpdates.swift
//  JMK (iOS)
//
//  Created by Emojiios on 11/01/2022.
//

import Foundation

class LatestUpdates {
    
    var Id : Int?
    var Title : String?
    var Body : String?
    var Photo : String?
    var Date : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Title = dictionary["Title"] as? String
        
    Body = dictionary["Body"] as? String
        
    Photo = dictionary["Photo"] as? String
    
    Date = dictionary["Date"] as? String 
    }
}

class LatestUpdatesDetails {
    

    var Title : String
    var Body : String
    var Photo : String
    var Date : String
    
    init(dictionary:[String:Any]) {
    Title = dictionary["Title"] as? String ?? ""
        
    Body = dictionary["Body"] as? String ?? ""
        
    Photo = dictionary["Photo"] as? String ?? ""
    
    Date = dictionary["Date"] as? String ?? ""
    }
    
}

