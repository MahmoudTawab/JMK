//
//  IGStory.swift
//
//  Created by Ranjith Kumar on 9/8/17
//  Copyright (c) DrawRect. All rights reserved.
//

import Foundation

struct IGStory: Codable {
    
    // Note: To retain lastPlayedSnapIndex value for each story making this type as class
    var snapsCount: Int {
        return snaps.count
    }

    // To hold the json snaps.
    var _snaps: [IGSnap]

    // To carry forwarding non-deleted snaps.
    var snaps: [IGSnap] {
        return _snaps.filter{!($0.isDeleted)}
    }

    var internalIdentifier: Int
    var Title: String
    var Icon: String

    var lastPlayedSnapIndex = 0
    var isCompletelyVisible = false
    var isCancelledAbruptly = false

    enum CodingKeys: String, CodingKey {
        //case snapsCount = "snaps_count"
        case _snaps = "Details"
        case internalIdentifier = "Id"
        case Title = "Title"
        case Icon = "Icon"
    }
    
}

extension IGStory: Equatable {
    public static func == (lhs: IGStory, rhs: IGStory) -> Bool {
        return lhs.internalIdentifier == rhs.internalIdentifier
    }
}



