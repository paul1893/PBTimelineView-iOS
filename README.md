# PBTimelineView-iOS

PBTimelineView is a view which enable you to clearly see what's going to happen.

<img src="https://raw.githubusercontent.com/paul1893/PBTimelineView-iOS/master/Screenshots/demo.gif" width="275" />  
<img src="https://raw.githubusercontent.com/paul1893/PBTimelineView-iOS/master/Screenshots/blue.png" width="275" /><img src="https://raw.githubusercontent.com/paul1893/PBTimelineView-iOS/master/Screenshots/purple.png" width="275" /><img src="https://raw.githubusercontent.com/paul1893/PBTimelineView-iOS/master/Screenshots/green.png" width="275" />

## Version
1.0.0  
## Installation

With Cocoapods simple add this to your podfile
```sh
pod PBTimelineView
```
or  Copy paste the lib folder on your project
## How to use
```swift
 mTimelineView.data = [
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"],
            ["Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance","Boxe","Dance"]				   
        ];
 mTimelineView.delegate = self
```
Note: For now you can only add texts programmatically.
## Delegate
If you have set a PBTimelineViewDelegate to the PBTimelineView you can handle the callback like this:
```swift
 func onClickItem(titleItem: String, id: Int, section: Int) {
       // Do stuff with item
       print("\(titleItem) on section \(section) and item n°\(id)");
 }
```
## License

MIT License

Copyright (c) [2016] [Paul Bancarel]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
