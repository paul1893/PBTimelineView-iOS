//
//  PBItem.swift
//  PBTimelineView
//
//  Created by Paul Bancarel on 10/07/2016.
//  Copyright © 2016 TheFrenchTouchDeveloper. All rights reserved.

import Foundation
import UIKit

public class PBItem:NSObject{

    public let section:Int! // The section position of the item in a timeline
    public let id:Int!      // The id of the item
    public let width:Int!   // His width
    public let height:Int!  // His height
    public let text:String! // His text
    public let backgroundColor:UIColor! // His background color
    public let textSize:CGFloat!    // His text size
    public let textColor:UIColor!   // His text color
    
    /**
     Construct an item
     
     - Parameters:
     - section
     - id
     - width
     - height
     - backgroundColor
     - text
     - textSize
     - textColor
     */
    public init(section:Int, id:Int, width:Int, height:Int, backgroundColor:UIColor, text:String, textSize:CGFloat, textColor:UIColor) {
        self.section = section
        self.id = id
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.text = text
        self.textSize = textSize
        self.textColor = textColor
    }
}
