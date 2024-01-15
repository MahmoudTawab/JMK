//
//  UpcomingEvent.swift
//  JMK (iOS)
//
//  Created by Emojiios on 11/01/2022.
//

import Foundation

class UpcomingEvent {
    
    var Id : Int?
    var Title : String?
    var Date : String?
    var ServerTime : String?

    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Title = dictionary["Title"] as? String
        
    Date = dictionary["Date"] as? String
        
    ServerTime = dictionary["ServerTime"] as? String
    }
}
