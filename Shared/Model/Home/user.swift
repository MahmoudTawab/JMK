//
//  user.swift
//  JMK (iOS)
//
//  Created by Emojiios on 11/01/2022.
//

import Foundation

class user {
    
    var Uid: String?
    var SqlId: String?
    var fName: String?
    var lName: String?
    var gender: Int?
    var Email: String?
    var phone: String?
    var Photo: String?
    var ReceiveNotifications: Bool?
    var ReceiveEmail: Bool?
    
    init(dictionary:[String:Any]) {
    Uid = dictionary["Uid"] as? String
        
    SqlId = dictionary["SqlId"] as? String
        
    fName = dictionary["fName"] as? String
        
    lName = dictionary["lName"] as? String
    
    gender = dictionary["gender"] as? Int
        
    Email = dictionary["Email"] as? String
        
    phone = dictionary["phone"] as? String
        
    Photo = dictionary["Photo"] as? String
        
    ReceiveNotifications = dictionary["ReceiveNotifications"] as? Bool
        
    ReceiveEmail = dictionary["ReceiveEmail"] as? Bool
    }
    
}
