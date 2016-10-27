//
//  WOWRibbonView.swift
//  WOWRibbonView
//
//  Created by Zhou Hao on 27/10/16.
//  Copyright © 2016年 Zhou Hao. All rights reserved.
//

import UIKit

@IBDesignable class WOWRibbonView: UIView {

    // MARK: properties
    
    // rift or arrow, default to arrow
    @IBInspectable var isRift : Bool = false {
        didSet {
            refreshConstraints()
            refreshDisplay()
        }
    }
    
    @IBInspectable var length : CGFloat = 5.0 {
        didSet {
            refreshConstraints()
            refreshDisplay()
        }
    }
    
    // left or right, default to right
    @IBInspectable var isLeft : Bool = false {
        didSet {
            refreshConstraints()
            refreshDisplay()
        }
    }
    
    // TODO: this is not supported by IB so I don't use them at the timebeing
//    private var _padding : UIEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
//    @IBInspectable
//    var padding: UIEdgeInsets {
//        get {
//            return _padding
//        }
//        set(newPadding) {
//            _padding = newPadding
//            refreshDisplay()
//        }
//    }
    
    @IBInspectable var top : CGFloat = 5.0 {
        didSet {
            refreshConstraints()
        }
    }
    
    @IBInspectable var left : CGFloat = 10.0 {
        didSet {
            refreshConstraints()
        }
    }
    
    @IBInspectable var right : CGFloat = 10.0 {
        didSet {
            refreshConstraints()
        }
    }
    
    @IBInspectable var bottom : CGFloat = 5.0 {
        didSet {
            refreshConstraints()
        }
    }
    
    @IBInspectable
    var text: String? {
        get {
            return _textLabel.text
        }
        set(newText) {
            _textLabel.text = newText
            refreshDisplay()
        }
    }
        
    @IBInspectable
    var textColor : UIColor {
        get {
            return _textLabel.textColor
        }
        set(newColor) {
            _textLabel.textColor = newColor
            refreshDisplay()
        }
    }
    
    // TODO: this is not supported to modify through IB
    @IBInspectable
    var textFont : UIFont {
        get {
            return _textLabel.font
        }
        set(newFont) {
            _textLabel.font = newFont
            refreshDisplay()
        }
    }
    
    @IBInspectable
    var textSize : CGFloat = 14.0 {
        didSet {
            let origFont = _textLabel.font
            _textLabel.font = UIFont(name: (origFont?.fontName)!, size: textSize)
            refreshDisplay()
        }
    }
    
    @IBInspectable
    var borderWidth : CGFloat = 0.0 {
        didSet {
            self._shape.lineWidth = borderWidth
            refreshDisplay()
        }
    }

    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet {
            self._shape.strokeColor = borderColor.cgColor
            refreshDisplay()
        }
    }
    
    @IBInspectable
    var fillColor : UIColor = UIColor.white {
        didSet {
            self._shape.fillColor = fillColor.cgColor
        }
    }
    
    // MARK: private properties

    private var _textLabel : UILabel = UILabel()

    private var _shape = CAShapeLayer()
    
    private var _verticalConstraints : [NSLayoutConstraint]?
    
    private var _horizontalConstraints : [NSLayoutConstraint]?
    
    private var _setup : Bool = false
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    // MARK: private methods
    
    // one time setup
    func setup() {
        
        if !_setup {
            
            _setup = true
            self._shape.lineCap = kCALineCapRound
            self._shape.lineJoin = kCALineJoinRound
            self.layer.addSublayer(_shape)
            
            // label on top of layer
            addSubview(_textLabel)
            _textLabel.backgroundColor = UIColor.clear

            _textLabel.translatesAutoresizingMaskIntoConstraints = false
            self.translatesAutoresizingMaskIntoConstraints = false

            refreshConstraints()
        }
    }
    
    func refreshConstraints() {
    
        if self._setup {
            let views : [String : UIView] = ["label" : _textLabel]
            let formatsH : String = self.isLeft ? "H:|-\(self.left + self.length)-[label]-\(self.right )-|" : "H:|-\(self.left)-[label]-\(self.right + self.length )-|"
            let formatsV : String = "V:|-\(self.top)-[label]-\(self.bottom)-|"
            
            if let vConstraints = self._verticalConstraints {
                NSLayoutConstraint.deactivate(vConstraints)
            }
            
            self._verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: formatsV, options: [], metrics: nil, views: views)
            
            if let hConstraints = self._horizontalConstraints {
                NSLayoutConstraint.deactivate(hConstraints)
            }
            
            self._horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: formatsH, options: [], metrics: nil, views: views)
            
            NSLayoutConstraint.activate(self._verticalConstraints!)
            NSLayoutConstraint.activate(self._horizontalConstraints!)
        }
        
//        self.setNeedsUpdateConstraints()
    }
    
    func refreshDisplay() {
        if _setup {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: draw
    
    override func draw(_ rect: CGRect) {
        
        // TODO: to consider the bounds orgin is not (0,0)
        let path = UIBezierPath()
        var p = CGPoint.zero
        
        if self.isRift {

            p.x = 0
            p.y = 0
            path.move(to: p)

            p.x = self.bounds.width
            path.addLine(to: p)

            if self.isLeft {
                p.y += self.bounds.height
                path.addLine(to: p)
                p.x = 0
                path.addLine(to: p)
                p.x += self.length
                p.y -= self.bounds.height / 2.0
                path.addLine(to: p)
                
            } else {
                p.x -= self.length
                p.y += self.bounds.height / 2.0
                path.addLine(to: p)
                p.x += self.length
                p.y += self.bounds.height / 2.0
                path.addLine(to: p)
                p.x = 0
                p.y = self.bounds.height
                path.addLine(to: p)
            }
            
            
        } else {
            
            if self.isLeft {
                
                p.x = 0
                p.y += self.bounds.height / 2.0
                path.move(to: p)
                
                p.x += self.length
                p.y = 0
                path.addLine(to: p)
                
                p.x = self.bounds.width
                path.addLine(to: p)
                
                p.y += self.bounds.height
                path.addLine(to: p)
                
                p.x = self.length
                path.addLine(to: p)
                
            } else {
                
                p.x = 0
                p.y = 0
                path.move(to: p)
                
                p.x = self.bounds.width - self.length
                path.addLine(to: p)
                
                p.x = self.bounds.width
                p.y += self.bounds.height / 2.0
                path.addLine(to: p)
                
                p.x = self.bounds.width - self.length
                p.y += self.bounds.height / 2.0
                path.addLine(to: p)
                
                p.x = 0
                path.addLine(to: p)
            }
        }
        
        path.close()
        self._shape.path = path.cgPath
    }

}
