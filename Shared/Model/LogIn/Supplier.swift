//
//  Supplier.swift
//  JMK (iOS)
//
//  Created by Emojiios on 13/01/2022.
//

import Foundation

class SupplierIndustry {
    
    var Id:String?
    var Name:String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? String
    Name = dictionary["Name"] as? String
    }
    
}
