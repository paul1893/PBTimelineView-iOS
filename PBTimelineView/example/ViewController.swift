//
//  ViewController.swift
//  PBTimelineView
//
//  Created by Paul Bancarel on 10/07/2016.
//  Copyright © 2016 TheFrenchTouchDeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PBTimelineViewDelegate {
    
    @IBOutlet var mTimelineView: PBTimelineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set some data
        mTimelineView.data = [
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance"]
        ];
        
        // Set the delegate for interaction with the PBTimelineView
        mTimelineView.delegate = self
        
    }
    
    /**
     Called when an item of the PBTimelineView is clicked
     */
    func onClickItem(titleItem: String, id: Int, section: Int) {
        print("\(titleItem) on section \(section) and item n°\(id)");
    }
}
