//
//  Notifications.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 09/12/2021.
//

import Foundation

class Notifications {
    
    var Id: Int?
    var Title: String?
    var Details: String?    
    var Date : String?
    
    init(dictionary:[String:Any]) {
       
    Id = dictionary["Id"] as? Int
    Title = dictionary["Title"] as? String
    Details = dictionary["Details"] as? String
    Date = dictionary["Date"] as? String

    }
}
