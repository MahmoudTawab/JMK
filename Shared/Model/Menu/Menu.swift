//
//  Menu.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 22/12/2021.
//

import Foundation


class MenuObject {
    
    var Categories = [Menu]()
    var Cart : [String:Any]?
    
    init(dictionary:[String:Any]) {
    for item in dictionary["Categories"] as? [[String:Any]] ?? [[String:Any]]() {
    Categories.append(Menu(dictionary: item))
    }
     
    Cart = dictionary["Cart"] as? [String:Any]
    }
}

class MenuSubObject {
    
    var SubCategory = [Menu]()
    var Cart : [String:Any]?
    
    init(dictionary:[String:Any]) {
    for item in dictionary["SubCategory"] as? [[String:Any]] ?? [[String:Any]]() {
    SubCategory.append(Menu(dictionary: item))
    }
     
    Cart = dictionary["Cart"] as? [String:Any]
    }
}

class Menu {
    
    var PackageId : String?
    var Name : String?
    var Icon : String?
    var HasSub : Bool?
    var type : String?
    var FatherId : String?
    
    var SubItems = [Menu]()
    init(dictionary:[String:Any]) {
        
    PackageId = dictionary["PackageId"] as? String
        
    Name = dictionary["Name"] as? String
        
    Icon = dictionary["Icon"] as? String
        
    HasSub = dictionary["HasSub"] as? Bool

    type = dictionary["Type"] as? String
        
    FatherId = dictionary["FatherId"] as? String
        
    for item in dictionary["SubPackages"] as? [[String:Any]] ?? [[String:Any]]() {
    SubItems.append(Menu(dictionary: item))
    }
        
    }
    
}


class MenuSubPackagesItems {
    
    var Id : Int?
    var Price : Int?
    var Name : String?
    var MainPhoto : String?
    var Description :String?
    var SubPackagesId : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Price = dictionary["Price"] as? Int
        
    Name = dictionary["Name"] as? String
        
    Description = dictionary["Description"] as? String
        
    MainPhoto = dictionary["MainPhoto"] as? String
    
    SubPackagesId = dictionary["SubPackagesId"] as? String
    }
    
}

class MenuPackagesItemsDetails {
    var Details : MenuPackagesItems?
    var Cart : [String:Any]?
    
    init(dictionary:[String:Any]) {
    if let details = dictionary["Details"] as? [String:Any]  {
    Details = MenuPackagesItems(dictionary: details)
    }
        
    Cart = dictionary["Cart"] as? [String:Any]
    }
}

class MenuPackagesItemsObject {
    
    var MenuItems = [MenuPackagesItems]()
    var Cart : [String:Any]?
    
    init(dictionary:[String:Any]) {
    for item in dictionary["Items"] as? [[String:Any]] ?? [[String:Any]]() {
    MenuItems.append(MenuPackagesItems(dictionary: item))
    }
     
    Cart = dictionary["Cart"] as? [String:Any]
    }
}

class MenuPackagesItems {
    
    var Id : Int?
    var Name : String?
    var Description : String?
    var Price : Int?
    var MainPhoto : String?
    var InCart : Bool?
    var Count : Int?
    
    var Favorite : Bool?
    var GalleryId : Int?
    var Capacity : Int?
    var ClassName : String?
    var Gallery = [ImageGallery]()
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
        
    Price = dictionary["Price"] as? Int
        
    Name = dictionary["Name"] as? String
        
    Description = dictionary["Description"] as? String
        
    MainPhoto = dictionary["MainPhoto"] as? String
    
    InCart = dictionary["InCart"] as? Bool
      
    Count = dictionary["Count"] as? Int
        
    Favorite = dictionary["Favorite"] as? Bool
        
    GalleryId = dictionary["GalleryId"] as? Int
        
    Capacity = dictionary["Capacity"] as? Int
    
    ClassName = dictionary["ClassName"] as? String
        
    for item in dictionary["Gallery"] as? [[String:Any]] ?? [[String:Any]]() {
    Gallery.append(ImageGallery(dictionary: item))
    }
        
    }
    
}

