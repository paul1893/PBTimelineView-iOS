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
        mTimelineView.data = [
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance"]
        ];
        mTimelineView.delegate = self
        
    }
    
    func onClickItem(titleItem: String, id: Int, section: Int) {
        print("\(titleItem) on section \(section) and item n°\(id)");
    }
    
}

