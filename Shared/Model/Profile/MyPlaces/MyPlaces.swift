//
//  MyPlaces.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 15/12/2021.
//

import UIKit
import Foundation

class MyPlaces {
    
    var Id : Int?
    var Name : String?
    var Address : String?
    var inCart : Bool?
    
    init(dictionary:[String:Any]) {
    Id = dictionary["Id"] as? Int
    Name = dictionary["Name"] as? String
    Address = dictionary["Address"] as? String
    inCart = dictionary["inCart"] as? Bool
    }
}



struct MyPlacesImage {
    
    var Image: UIImage?
    var islocal: Bool
    var Path : String?

    init(Path:String ,Image: UIImage, islocal: Bool = false) {
    self.Path = Path
    self.islocal = islocal
    self.Image = Image
  }
    
}


class MyPlacesDetails {
    
    var Id : Int?
    var Area : Int?
    var Address : String?
    
    var Name: String?
    var Indoor: Bool?
    var type: String?
    var Photo = [ImageGallery]()

    init(dictionary:[String:Any]) {
       
    Id = dictionary["Id"] as? Int
    Area = dictionary["Area"] as? Int
    Address = dictionary["Address"] as? String
        
    Name = dictionary["Name"] as? String
    Indoor = dictionary["Indoor"] as? Bool
    type = dictionary["Type"] as? String
                
    for item in dictionary["Photo"] as? [[String:Any]] ?? [[String:Any]()] {
    Photo.append(ImageGallery(dictionary: item))
    }
    }
}



