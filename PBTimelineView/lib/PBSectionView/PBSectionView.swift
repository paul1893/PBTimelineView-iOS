//
//  PBSectionView.swift
//  PBTimelineView
//
//  Created by Paul Bancarel on 10/07/2016.
//  Copyright © 2016 TheFrenchTouchDeveloper. All rights reserved.

import UIKit

public protocol PBSectionViewDelegate{
    func onTouchItem(item:PBItem) // Called when an item is touched
}
public class PBSectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public var items:[PBItem] = [] // The items in the section
    public var sectionDelegate:PBSectionViewDelegate? // The delegate for callbacks
    
    
    /**
     Constructor
     
     - Parameters:
     - frame
     - collectionViewLayout
     */
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupConfiguration()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConfiguration()
    }
    
    /**
     Setup configuration for the section view (backgroundColor, dataSource, flowLayout, etc)
     */
    private func setupConfiguration(){
        self.backgroundColor = UIColor.clearColor()
        self.dataSource = self
        self.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionViewLayout = flowLayout
        
        self.showsHorizontalScrollIndicator = false
        self.registerNib(UINib(nibName: "PBSectionCell", bundle: nil), forCellWithReuseIdentifier: "pbsectioncell")
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pbsectioncell", forIndexPath: indexPath) as! PBSectionCell
        let item = items[indexPath.row]
        
        // Set the cell
        cell.label.text = item.text
        cell.label.textColor = item.textColor
        cell.view.backgroundColor = item.backgroundColor
        
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 40)
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        sectionDelegate?.onTouchItem(items[indexPath.row])
    }
    
}
