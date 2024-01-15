//
//  Settings.swift
//  JMK (iOS)
//
//  Created by Emojiios on 13/01/2022.
//

import Foundation

class NotificationsSettings {
    
    var NotificationsSta : Bool?
    var EmailSta : Bool?
    
    init(dictionary:[String:Any]) {
    NotificationsSta = dictionary["NotificationsSta"] as? Bool
        
    EmailSta = dictionary["EmailSta"] as? Bool
    }
}

class TermsOfService {
    
    var Title : String?
    var Body : String?
    
    init(dictionary:[String:Any]) {
    Title = dictionary["Title"] as? String
        
    Body = dictionary["Body"] as? String
    }
}


class PrivacyPolicy {
    
    var Title : String?
    var Body : String?
    
    init(dictionary:[String:Any]) {
    Title = dictionary["Title"] as? String
        
    Body = dictionary["Body"] as? String
        
    }
}
