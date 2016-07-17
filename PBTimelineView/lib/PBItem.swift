//
//  PBItem.swift
//  PBTimelineView
//
//  Created by Paul Bancarel on 10/07/2016.
//  Copyright © 2016 TheFrenchTouchDeveloper. All rights reserved.
//

import Foundation
import UIKit

public class PBItem:NSObject{

    public let section:Int!
    public let id:Int!
    public let width:Int!
    public let height:Int!
    public let text:String!
    public let backgroundColor:UIColor!
    public let textSize:CGFloat!
    public let textColor:UIColor!
    
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