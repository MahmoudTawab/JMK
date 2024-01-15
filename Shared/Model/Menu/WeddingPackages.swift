//
//  WeddingPackages.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 22/12/2021.
//

import Foundation

class PackagesWedding {
    
    var Id : Int?
    var Icon : String?
    var BudgetTo : Int?
    var BudgetFrom : Int?
    var PackageName : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
    PackageName = dictionary["PackageName"] as? String
        
    Icon = dictionary["Icon"] as? String
    BudgetFrom = dictionary["BudgetFrom"] as? Int
    BudgetTo = dictionary["BudgetTo"] as? Int
    }
    
}


class PackagesWeddingDetils {
    
    var Id : Int?
    var Name : String?
    var Icon : String?
    var BudgetFrom : Int?
    var BudgetTo : Int?
    var inCart : Bool?
    var Gallery = [ImageGallery]()
    var SubCategories = [PackagesDetilsSub]()
    
    init(dictionary:[String:Any]) {
        
    Id = dictionary["Id"] as? Int
        
    Name = dictionary["Name"] as? String
        
    Icon = dictionary["Icon"] as? String
        
    BudgetFrom = dictionary["BudgetFrom"] as? Int
        
    BudgetTo = dictionary["BudgetTo"] as? Int
        
    inCart = dictionary["inCart"] as? Bool
        
    for item in dictionary["Gallery"] as? [[String:Any]] ?? [[String:Any]]() {
    Gallery.append(ImageGallery(dictionary: item))
    }
       
        
    for item in dictionary["SubCategories"] as? [[String:Any]] ?? [[String:Any]]() {
    SubCategories.append(PackagesDetilsSub(dictionary: item))
    }
    }
    
}



class PackagesDetilsSub {
    
    var Id : Int?
    var Name : String?
    var HasSub : Bool?
    var Items = [PackagesDetilsSubItems]()
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Name = dictionary["Name"] as? String
        
    HasSub = dictionary["HasSub"] as? Bool
    
    for item in dictionary["Items"] as? [[String:Any]] ?? [[String:Any]]() {
    Items.append(PackagesDetilsSubItems(dictionary: item))
    }
        
    }
}


class PackagesDetilsSubItems {
    
    var Id : Int?
    var Name : String?
    var Count : Int?
    var SubPackagesId : String?
    var Description : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Count = dictionary["Count"] as? Int
        
    Name = dictionary["Name"] as? String
        
    Description = dictionary["Description"] as? String
        
    SubPackagesId = dictionary["SubPackagesId"] as? String
    }
}

class ImageGallery {
    
    var PhotoPath:String?
    init(dictionary:[String:Any]) {
    PhotoPath = dictionary["PhotoPath"] as? String
    }
    
}
