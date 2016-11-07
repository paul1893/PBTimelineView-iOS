//
//  PBTimelineView.swift
//  PBTimelineView
//
//  Created by Paul Bancarel on 17/02/2016.
//  Copyright © 2016 Paul Bancarel. All rights reserved.
//

import Foundation
import UIKit

public protocol PBTimelineViewDelegate{
    func onClickItem(titleItem:String, id:Int, section:Int) // Call when an item of the timeline is clicked
}

@IBDesignable
public class PBTimelineView:UIView, PBSectionViewDelegate{
    
    /* Sizes */
    @IBInspectable
    public  var widthItem:CGFloat = 100
    @IBInspectable
    public  var heightItem:CGFloat = 40
    @IBInspectable
    public  var mainTextSize:CGFloat = 18
    @IBInspectable
    public  var textSize:CGFloat = 15
    @IBInspectable
    public  var textSizeItem:CGFloat = 15
    
    
    /* Structure */
    @IBInspectable
    public  var numberOfPoints:Int = 7
    @IBInspectable
    public  var radiusPoint:CGFloat = 2.0
    @IBInspectable
    public  var strokeLine:CGFloat = 2.0
    @IBInspectable
    public  var leftOffset:Int = 30
    
    /* Calendar */
    @IBInspectable
    public  var isCalendarEnabled: Bool = true;
    var texts:Array<String> = []
    @IBInspectable
    public  var mainText: String = "Title";
    
    /* Colors */
    @IBInspectable
    public  var backgroundColorItems: UIColor = UIColor(red: 59/255, green: 119/255, blue: 231/255, alpha: 1)
    @IBInspectable
    public  var lineColor: UIColor = UIColor.grayColor()
    @IBInspectable
    public  var pointColor: UIColor = UIColor.blackColor()
    @IBInspectable
    public  var mainTextColor: UIColor = UIColor.blackColor()
    @IBInspectable
    public  var textColor: UIColor = UIColor.blackColor()
    @IBInspectable
    public  var textColorItem: UIColor = UIColor.whiteColor()
    
    
    public var data: Array<Array<String>>!{ // The Texts of the items: 2D Array
        didSet{
            //Fresh base
            self.subviews.forEach {
                (var view) -> () in
                if (view is UIButton) {
                    view.removeFromSuperview()
                }
            }
            //Re-Draw
            self.setNeedsDisplay()
        }
    }
    public var delegate:PBTimelineViewDelegate?
    
    /* Others */
    let padding:CGFloat = 10
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialisation()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialisation()
    }
    
    private func initialisation(){
        self.data = []
        
        if isCalendarEnabled{
            updateCalendar()
        }
    }
    
    /**
     Update texts with calendar elements
     */
    public func updateCalendar(){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        /*let year =  components.year*/ // TODO: Activate this on the next update
        let month = components.month
        let day = components.day
        
        // Generate Date
        mainText = "Nous sommes le \(day)/\(month)"
        
        // Generate Days
        texts = getNextDaysName(numberOfPoints)
    }
    
    /**
     Drawing the timeline view on the rectangle
     
     - Parameters:
     - rect: Rect surface to draw
     */
    public override func drawRect(rect: CGRect) {
        lineColor.setFill()
        lineColor.setStroke()
        
        /* Method 1: */
        // Draw the vertical line
        var path = UIBezierPath()
        path.lineWidth = strokeLine
        var startPoint = CGPoint(x: leftOffset, y: 0)
        let endPoint = CGPoint(x: leftOffset, y: Int(self.frame.size.height))
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        
        // Drawing
        path.stroke() //OR applySublayer(path)
        
        // Write the title
        var attrs = fontAttributes("Helvetica Light", fontSize: mainTextSize, textColor: mainTextColor, textAlignement: NSTextAlignment.Left)
        mainText.drawInRect(CGRectMake(CGFloat(leftOffset) + padding, 30, self.frame.size.width, 40), withAttributes: attrs)
        
        // Divide the line in equal segment
        let fraction:Int = Int(self.frame.size.height) / numberOfPoints
        
        // Draw the circle and the title at the intersection of each segment
        for (var i = 1; i < numberOfPoints; i += 1) {
            let k = i-1
            
            // Center point
            startPoint = CGPoint(x: leftOffset-Int(radiusPoint), y: fraction*i)
            
            // Draw circle
            path = UIBezierPath(ovalInRect:CGRect(origin: startPoint,size: CGSize(width: radiusPoint*2, height: radiusPoint*2)))
            path.fill()
            
            // Drawing
            path.stroke() //OR applySublayer(path)
            
            // Write the event
            if texts.count > 0 {
                let textToWrite = texts[k]
                attrs = fontAttributes("Helvetica Light", fontSize: textSize, textColor: textColor, textAlignement: NSTextAlignment.Left)
                textToWrite.drawInRect(CGRectMake(CGFloat(leftOffset) - textToWrite.size(attrs).width - padding, startPoint.y-radiusPoint-(textToWrite.size(attrs).height/2), CGFloat(leftOffset), 25), withAttributes: attrs)
            }
            
            // Draw the Event
            if (k < data.count){
                let sectionView = PBSectionView(frame: CGRectMake(startPoint.x+padding, startPoint.y - (heightItem/2), self.frame.width-CGFloat(leftOffset)-padding , heightItem), collectionViewLayout:UICollectionViewFlowLayout())
                var pbitems:Array<PBItem> = []
                for (var j = 0; j < data[k].count; j+=1) {
                    let string = data[k][j]
                    pbitems.append(PBItem(section: k, id: j, width: Int(widthItem), height: Int(heightItem), backgroundColor: backgroundColorItems, text: string, textSize: textSizeItem, textColor: UIColor.whiteColor()))
                }
                sectionView.items = pbitems
                sectionView.sectionDelegate = self
                self.addSubview(sectionView)
            }
            
        }
        
        /* Method 2 (DEPRECATED) */
        /* let context = UIGraphicsGetCurrentContext()
         CGContextSaveGState(context);
         
         CGContextSetStrokeColorWithColor(context, lineColor.CGColor)
         CGContextSetFillColorWithColor(context, lineColor.CGColor)
         CGContextSetLineWidth(context, 2.0)
         
         //Draw the vertical line
         var startPoint = CGPoint(x: leftOffset,y: 0)
         var endPoint = CGPoint(x: leftOffset, y: Int(self.frame.size.height))
         
         CGContextMoveToPoint(context, startPoint.x, startPoint.y)
         CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
         
         
         CGContextStrokePath(context)
         
         let fraction:Int = Int(self.frame.size.height) / numberOfPoints
         
         //Draw the circle
         for var i = 1; i<numberOfPoints; i++ {
         startPoint = CGPoint(x: leftOffset,y: fraction*i)
         
         //CGContextAddArc(context, startPoint.x, startPoint.y, radiusPoint, 0, CGFloat(2*M_PI), 1)
         CGContextAddEllipseInRect(context, CGRect(origin: startPoint, size: CGSize(width: radiusPoint*2, height: radiusPoint*2)))
         // Fill the content
         CGContextFillPath(context)
         
         CGContextStrokePath(context)
         
         }
         
         CGContextRestoreGState(context);*/
    }
    
    /**
     Apply a sub layer to the current layer
     
     - Parameters:
     */
    private func applySublayer(path :UIBezierPath){
        // Create a ShapeLayer
        let shapeLayer = CAShapeLayer()
        // Change the fill color
        shapeLayer.fillColor = lineColor.CGColor
        // Change the stroke color
        shapeLayer.strokeColor = lineColor.CGColor
        // Change the line width
        shapeLayer.lineWidth = strokeLine
        shapeLayer.path = path.CGPath
        self.layer.addSublayer(shapeLayer)
    }
    
    /**
     Get fonts attributes for the events
     
     - Parameters:
     - fontName: The name of the font you want
     - fontSize: The size of the font you want
     - textColor: The color of the text you want
     - textAlignement: The alignement of the text you want
     
     - Returns: attributes
     */
    private func fontAttributes(fontName:String, fontSize:CGFloat, textColor:UIColor, textAlignement:NSTextAlignment) -> [String : AnyObject]{
        let font:UIFont = UIFont(name: fontName, size: fontSize)!
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = textAlignement
        let textColor:UIColor = textColor
        
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: textStyle
        ]
        
        return textFontAttributes
    }
    
    /**
     Call when an item of the timeline is touched
     
     - Parameters:
     - item: The item that has been touched
     */
    public func onTouchItem(item:PBItem){
        delegate?.onClickItem(item.text, id: item.id, section: item.section)
    }
    
    /**
     Get names of the 'n' next days. Starting from now
     
     - Parameters:
     - n: The number of next days
     
     - Returns: names
     */
    private func getNextDaysName(n:Int) -> Array<String>{
        
        var arrayDaysString:Array<String> = []
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = NSCalendar.currentCalendar()
        var components:NSDateComponents!
        var dayOfWeekString:String!
        
        for i in 0 ..< n {
            let date = NSDate(timeIntervalSinceNow: Double(i*24*60*60))
            
            components = calendar.components([.Weekday , .Day , .Month], fromDate: date)
            dayOfWeekString = dateFormatter.stringFromDate(date)
            
            arrayDaysString.append("\(dayOfWeekString) \(components.day)")
        }
        
        return arrayDaysString
    }
}

public extension String{
    func size(attrs:[String : AnyObject]?) -> CGSize{
        return NSString(string: self).sizeWithAttributes(attrs)
    }
}
