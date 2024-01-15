//
//  JWT.swift
//  JMK (iOS)
//
//  Created by Emojiios on 23/02/2022.
//

import Foundation

class JWT {
    
    var Token:String?
    var ExpiresOn:String?
    
    init(dictionary:[String:Any]) {
    Token = dictionary["Token"] as? String
    ExpiresOn = dictionary["ExpiresOn"] as? String
    }
    
}
