//
//  MyEvents.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 22/12/2021.
//

import Foundation

class AllEventObject {
    
    var InProgress = [AllEvent]()
    var Upcoming = [AllEvent]()
    var Past = [AllEvent]()
    
    init(dictionary:[String:Any]) {
        
    for item in dictionary["InProgress"] as? [[String:Any]] ?? [[String:Any]()] {
    InProgress.append(AllEvent(dictionary: item))
    }
        
    for item in dictionary["Upcoming"] as? [[String:Any]] ?? [[String:Any]()] {
    Upcoming.append(AllEvent(dictionary: item))
    }
        
    for item in dictionary["Past"] as? [[String:Any]] ?? [[String:Any]()] {
    Past.append(AllEvent(dictionary: item))
    }
        
    }
}

class AllEvent {
    
    var Id : Int?
    var Title : String?
    var EventRate : Int?
    var CompletedRat : Int?
    var StartDate : String?
    var CartId : Int?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Title = dictionary["Title"] as? String
        
    EventRate = dictionary["EventRate"] as? Int
        
    CompletedRat = dictionary["CompletedRat"] as? Int
        
    StartDate = dictionary["StartDate"] as? String
        
    CartId = dictionary["CartId"] as? Int
    }
    
}

