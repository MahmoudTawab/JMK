//
//  cart.swift
//  JMK (iOS)
//
//  Created by Emojiios on 11/01/2022.
//

import Foundation

class cart {
    
    var EvintId: Int?
    var CartId: Int?
    var Title: String?
    var StartDate: String?
    var CompletedRat: Int?
    var CartItemCount: Int?
    var CategoryId: String?
    var CategoryName: String?
    var BudgetTo: Int?
    var BudgetFrom: Int?
    var AttendeesTo: Int?
    var AttendeesFrom: Int?
    
    init(dictionary:[String:Any]) {
        
    EvintId = dictionary["EvintId"] as? Int
        
    CartId = dictionary["CartId"] as? Int
        
    Title = dictionary["Title"] as? String
        
    StartDate = dictionary["StartDate"] as? String

    CompletedRat = dictionary["CompletedRat"] as? Int
        
    CartItemCount = dictionary["CartItemCount"] as? Int
        
    CategoryId = dictionary["CategoryId"] as? String
        
    CategoryName = dictionary["CategoryName"] as? String
        
    BudgetTo = dictionary["BudgetTo"] as? Int
        
    BudgetFrom = dictionary["BudgetFrom"] as? Int
    
    AttendeesTo = dictionary["AttendeesTo"] as? Int
        
    AttendeesFrom = dictionary["AttendeesFrom"] as? Int
    }
    
}


class CartDetils {
    
   var WeddingPackages : CartWeddingPackages?
   var AttendeesTo : Double?
   var BudgetTo : Double?
   var Total : Double?
   var Detils = [AllCartDetils]()
    
    init(dictionary:[String:Any]) {
    if let Packages = dictionary["WeddingPackages"] as? [String:Any] {
    WeddingPackages = CartWeddingPackages(dictionary: Packages)
    }
        
    AttendeesTo = dictionary["AttendeesTo"] as? Double
    BudgetTo = dictionary["BudgetTo"] as? Double
    Total = dictionary["Total"] as? Double

    for item in dictionary["CartDetils"] as? [[String:Any]] ?? [[String:Any]()] {
    Detils.append(AllCartDetils(dictionary: item))
    }
    }
}

class CartWeddingPackages {
    var Id : Int?
    var PackageName : String?
    
    init(dictionary:[String:Any]) {
        Id = dictionary["Id"] as? Int
        PackageName = dictionary["PackageName"] as? String
    }
    
}

class AllCartDetils {
    
    var PackageId : String?
    var PackagName : String?
    var PackageTotal : Double?
    var SubPackages = [CartSubPackages]()
    
    init(dictionary:[String:Any]) {
    PackageId = dictionary["PackageId"] as? String
    PackagName = dictionary["PackagName"] as? String
    PackageTotal = dictionary["PackageTotal"] as? Double
        
    for item in dictionary["SubPackages"] as? [[String:Any]] ?? [[String:Any]()] {
    SubPackages.append(CartSubPackages(dictionary: item))
    }
    }
    
}

class CartSubPackages {
    
    var PackageId : String?
    var Name : String?
    var Count : Int?
    var TotalPrice : Double?
    
    init(dictionary:[String:Any]) {
    PackageId = dictionary["PackageId"] as? String
    Name = dictionary["Name"] as? String
    Count = dictionary["Count"] as? Int
    TotalPrice = dictionary["TotalPrice"] as? Double
    }
}

struct AddToCart: Encodable {
    var Id : Int?
    var Count : Int?
}

