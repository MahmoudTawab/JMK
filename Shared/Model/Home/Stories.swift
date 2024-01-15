//
//  Stories.swift
//  JMK (iOS)
//
//  Created by Emojiios on 23/01/2022.
//

import Foundation


public enum MimeType: String {
    case image
    case video
    case unknown
}

class IGStory {
    
 var internalIdentifier : Int
 var Title : String
 var Icon : String
    
 // Note: To retain lastPlayedSnapIndex value for each story making this type as class
 var snapsCount: Int {
 return snaps.count
 }
    
 // To hold the json snaps.
 var _snaps = [IGSnap]()
    
  // To carry forwarding non-deleted snaps.
 var snaps: [IGSnap] {
 return _snaps.filter{!($0.isDeleted)}
 }
    
 var lastPlayedSnapIndex = 0
 var isCompletelyVisible = false
 var isCancelledAbruptly = false
    
 init(dictionary:[String:Any]) {
   
    internalIdentifier = dictionary["Id"] as? Int ?? 0
    Title = dictionary["Title"] as? String ?? ""
    Icon = dictionary["Icon"] as? String ?? ""
     
    if let Details = dictionary["Details"] as? [[String:Any]] {
    for item in Details {
    _snaps.append(IGSnap(dictionary: item))
    }
    }
 }
    
}

extension IGStory: Equatable {
    public static func == (lhs: IGStory, rhs: IGStory) -> Bool {
        return lhs.internalIdentifier == rhs.internalIdentifier
    }
}

class IGSnap {
    
    var internalIdentifier : String
    var mimeType : String
    var Text : String
    var url : String
    var timer : Int
    var CreatedIn : String
    
    init(dictionary:[String:Any]) {
    internalIdentifier = "\(dictionary["Id"] as? Int ?? 0)"
    mimeType = dictionary["MediaType"] as? String ?? ""
    Text = dictionary["Text"] as? String ?? ""
    url = dictionary["Path"] as? String ?? ""
    timer = dictionary["Timer"] as? Int ?? 0
    CreatedIn = dictionary["CreatedIn"] as? String ?? ""
    }
    
    // Store the deleted snaps id in NSUserDefaults, so that when app get relaunch deleted snaps will not display.
    public var isDeleted: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: internalIdentifier)
        }
        get{
            return UserDefaults.standard.value(forKey: internalIdentifier) != nil
        }
    }
    
    public var kind: MimeType {
        switch mimeType {
            case MimeType.image.rawValue:
                return MimeType.image
            case MimeType.video.rawValue:
                return MimeType.video
            default:
                return MimeType.unknown
        }
    }
}

