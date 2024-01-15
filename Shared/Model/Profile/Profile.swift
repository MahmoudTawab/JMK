//
//  Profile.swift
//  JMK (iOS)
//
//  Created by Emojiios on 13/01/2022.
//

import Foundation

class ProfileObject {
    
    var user : [String:Any]?
    var Cart : [String:Any]?
    
    init(dictionary:[String:Any]) {
    user = dictionary["user"] as? [String:Any]
    
    Cart = dictionary["Cart"] as? [String:Any]
        
    if let Upcoming = dictionary["MyUpcomingEvent"] as? [String:Any]  {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: Upcoming)
    defaults.set(encodedData, forKey: "UpcomingEvent")
    defaults.synchronize()
    }
    }
}
