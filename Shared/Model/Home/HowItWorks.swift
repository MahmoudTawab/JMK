//
//  HowItWorks.swift
//  JMK (iOS)
//
//  Created by Emojiios on 22/02/2022.
//

import Foundation


class HowItWorks {
    
    var id : String?
    var title : String?
    var body : String?
    var icon : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
        
    title = dictionary["title"] as? String
        
    body = dictionary["body"] as? String
        
    icon = dictionary["icon"] as? String
    }
}
