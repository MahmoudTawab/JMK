//
//  EventCategory.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 19/12/2021.
//

import Foundation


class EventCategory {
    
    var Id : String?
    var Name : String?
    var Icon : String?
    var Couple : String?
    var HasSub : Bool?
    
    var Controls : EventCategoryControls?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? String
    Name = dictionary["Name"] as? String
    Icon = dictionary["Icon"] as? String
        
    Couple = dictionary["Couple"] as? String
    HasSub = dictionary["HasSub"] as? Bool
        
    if let SubDictionary = dictionary["Controls"] as? [String:Any]  {
    Controls = EventCategoryControls(dictionary: SubDictionary)
    }
        
    }
}

class EventCategoryControls {
    
    var CategoryId : String?
    var TitleValue : String?
    var GroomName : Bool?
    var Gender : Bool?
    var Age : Bool?
    var DelegateName : Bool?
    var DelegatePhone : Bool?
    var BudgetFrom : Int?
    var BudgetTo : Int?
    var AttendeesFrome : Int?
    var AttendeesTo : Int?
    var MinDays : Int?
    
    init(dictionary:[String:Any]) {
       
        CategoryId = dictionary["CategoryId"] as? String
        TitleValue = dictionary["TitleValue"] as? String
        GroomName = dictionary["GroomName"] as? Bool
        
        Gender = dictionary["Gender"] as? Bool
        Age = dictionary["Age"] as? Bool
        
        DelegateName = dictionary["DelegateName"] as? Bool
        DelegatePhone = dictionary["DelegatePhone"] as? Bool
    
        BudgetFrom = dictionary["BudgetFrom"] as? Int
        BudgetTo = dictionary["BudgetTo"] as? Int
        AttendeesFrome = dictionary["AttendeesFrome"] as? Int
        
        AttendeesTo = dictionary["AttendeesTo"] as? Int
        MinDays = dictionary["MinDays"] as? Int
    }
}

class EventCategorySub {
    
    var Id : String?
    var Name : String?
    var Icon : String?
    var Controls : EventCategoryControls?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? String
    Name = dictionary["Name"] as? String
    Icon = dictionary["Icon"] as? String
        
    if let SubDictionary = dictionary["Controls"] as? [String:Any]  {
    Controls = EventCategoryControls(dictionary: SubDictionary)
    }
    }
}

class EventCategoryColors {
    
    var Id : Int?
    var IconPath : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
    IconPath = dictionary["IconPath"] as? String
    }
    
}

class EventClassicMusic {
    
    var Id : Int?
    var Name : String?
    var IconPath : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
    Name = dictionary["Name"] as? String
    IconPath = dictionary["IconPath"] as? String
    }
    
}


class EventModernMusic {
    
    var Id : Int?
    var Name : String?
    var IconPath : String?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
    Name = dictionary["Name"] as? String
    IconPath = dictionary["IconPath"] as? String
    }
    
}
