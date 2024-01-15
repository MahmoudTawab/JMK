//
//  WhatWeOffer.swift
//  JMK (iOS)
//
//  Created by Emojiios on 22/02/2022.
//

import Foundation

class WhatWeOffer {
    
    var id : String?
    var title : String?
    var body : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
        
    title = dictionary["title"] as? String
        
    body = dictionary["body"] as? String
    }
}
