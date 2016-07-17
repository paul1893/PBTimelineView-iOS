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
    
    func onClickItem(titleItem:String, id:Int, section:Int)
    
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
    public  var leftOffset:Int = 30{
        didSet{
            
        }
    }
    
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
    
    /* Needs two variable cannot assign a value to itself in the set and cannot return itself in the get. Not their purpose. */
    //    private var data: Array<Array<String>>!
    //    var dataSource: Array<Array<String>>{
    //        get{
    //            return self.data
    //            }
    //        set {
    //            self.data = newValue
    //            self.setNeedsDisplay()
    //            }
    //    }
    
    //OR
    
    public var data: Array<Array<String>>!{
        // or WillSet
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
    
    public func updateCalendar(){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        //let year =  components.year
        let month = components.month
        let day = components.day
        
        // Generate Date
        mainText = "Nous sommes le \(day)/\(month)"
        
        // Generate Days
        texts = getNextDaysName(numberOfPoints)
    }
    
    public override func drawRect(rect: CGRect) {
        lineColor.setFill()
        lineColor.setStroke()
        
        // Method 1
        // Draw the vertical line
        var path = UIBezierPath()
        path.lineWidth = strokeLine
        var startPoint = CGPoint(x: leftOffset, y: 0)
        var endPoint = CGPoint(x: leftOffset, y: Int(self.frame.size.height))
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        
        // On dessine
        path.stroke()
        //OR
        //applySublayer(path)
        
        
        //Write the title
        var attrs = fontAttributes("Helvetica Light", fontSize: mainTextSize, textColor: mainTextColor, textAlignement: NSTextAlignment.Left)
        mainText.drawInRect(CGRectMake(CGFloat(leftOffset) + padding, 30, self.frame.size.width, 40), withAttributes: attrs)
        
        
        
        let fraction:Int = Int(self.frame.size.height) / numberOfPoints
        
        //Draw the circle and the title
        for (var i = 1; i < numberOfPoints; i += 1) {
            let k = i-1
            
            // On centre le point
            startPoint = CGPoint(x: leftOffset-Int(radiusPoint), y: fraction*i)
            
            // On trace le cercle
            path = UIBezierPath(ovalInRect:CGRect(origin: startPoint,size: CGSize(width: radiusPoint*2, height: radiusPoint*2)))
            path.fill()
            
            // On dessine
            path.stroke()
            //OR
            //applySublayer(path)
            
            //Write the event
            if texts.count > 0 {
                let textToWrite = texts[k]
                attrs = fontAttributes("Helvetica Light", fontSize: textSize, textColor: textColor, textAlignement: NSTextAlignment.Left)
                textToWrite.drawInRect(CGRectMake(CGFloat(leftOffset) - textToWrite.size(attrs).width - padding, startPoint.y-radiusPoint-(textToWrite.size(attrs).height/2), CGFloat(leftOffset), 25), withAttributes: attrs)
            }
            
            //Draw Event
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
        
        /* // Method 2 (deprecated)
         let context = UIGraphicsGetCurrentContext()
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
    
    private func applySublayer(path :UIBezierPath){
        
        //Params
        var shapeLayer = CAShapeLayer()
        //change the fill color
        shapeLayer.fillColor = lineColor.CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = lineColor.CGColor
        //you can change the line width
        shapeLayer.lineWidth = strokeLine
        shapeLayer.path = path.CGPath
        self.layer.addSublayer(shapeLayer)
        
    }
    
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
    
    public func onTouchItem(item:PBItem){
        delegate?.onClickItem(item.text, id: item.id, section: item.section)
        
    }
    
    private func getNextDaysName(n:Int) -> Array<String>{
        
        var arrayDaysString:Array<String> = []
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = NSCalendar.currentCalendar()
        var components:NSDateComponents!
        var dayOfWeekString:String!
        
        for var i = 0; i < n; i += 1 {
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