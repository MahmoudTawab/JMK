//
//  Model.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 07/12/2021.
//

import Foundation


class Model {
      
    var IsUser : Bool?
    
    var JWT : String?
    
    init(dictionary:[String:Any]) {
       
    if let ISUser = dictionary["IsUser"] as? Bool {
    IsUser = ISUser
    }
        
    if let Jwt = dictionary["JWT"] as? String {
    JWT = Jwt
    defaults.set(Jwt, forKey: "JWT")
    }
        
    ///
    if let UserData = dictionary["user"] as? [String:Any]  {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: UserData)
    defaults.set(encodedData, forKey: "User")
    defaults.synchronize()
    }
        
    ///
    if let CartData = dictionary["Cart"] as? [String:Any] {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: CartData)
    defaults.set(encodedData, forKey: "Cart")
    defaults.synchronize()
    }

    ///
    if let StoriesData = dictionary["Stories"] as? [[String:Any]] {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: StoriesData)
    defaults.set(encodedData, forKey: "Stories")
    defaults.synchronize()
    }

    ///
    if let Upcoming = dictionary["UpcomingEvent"] as? [String:Any] {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: Upcoming)
    defaults.set(encodedData, forKey: "UpcomingEvent")
    defaults.synchronize()
    }

    ///

    if let UpdatesLatest = dictionary["LatestUpdates"] as? [[String:Any]]  {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: UpdatesLatest)
    defaults.set(encodedData, forKey: "LatestUpdates")
    defaults.synchronize()
    }
        
     ///
    if let pending = dictionary["pendinginvitation"] as? [[String:Any]]  {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: pending)
    defaults.set(encodedData, forKey: "Pendinginvitation")
    defaults.synchronize()
    }
        
    //
    if let HowWorksData = dictionary["HowItWorks"] as? [String:Any] {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: HowWorksData)
    defaults.set(encodedData, forKey: "HowItWorks")
    defaults.synchronize()
    }
        
    //
    if let offer = dictionary["WhatWeOffer"] as? [String:Any] {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: offer)
    defaults.set(encodedData, forKey: "WhatWeOffer")
    defaults.synchronize()
    }
        
    }


}
