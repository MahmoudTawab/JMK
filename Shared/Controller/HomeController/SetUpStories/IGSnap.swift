//
//  IGSnap.swift
//
//  Created by Ranjith Kumar on 9/28/17
//  Copyright (c) DrawRect. All rights reserved.
//

import Foundation

public enum MimeType: String {
    case image
    case video
    case unknown
}

public struct IGSnap: Codable {
    
    public let internalIdentifier: String
    public let mimeType: String
    public let Text: String
    public let url: String
    public let timer: Int
    public let CreatedIn: String
    
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
    
    enum CodingKeys: String, CodingKey {
        case internalIdentifier = "Id"
        case mimeType = "MediaType"
        case Text = "Text"
        case url = "Path"
        case timer = "Timer"
        case CreatedIn = "CreatedIn"
    }
}
