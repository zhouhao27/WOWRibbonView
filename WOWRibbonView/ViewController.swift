//
//  ViewController.swift
//  WOWRibbonView
//
//  Created by Zhou Hao on 27/10/16.
//  Copyright © 2016年 Zhou Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var ribbon1 : WOWRibbonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ribbon1 = WOWRibbonView(frame: CGRect())
        self.view.addSubview(self.ribbon1)
        
        let views : [String : UIView] = ["view" : self.ribbon1]
        
        // align ribbon from the left
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]", options:[], metrics: nil, views: views));
        
        // align ribbon from the top
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-300-[view]", options: [], metrics: nil, views: views));
                
        self.ribbon1.backgroundColor = UIColor.clear
        self.ribbon1.text = "Right Rift by code ..."
        self.ribbon1.isLeft = false
        self.ribbon1.isRift = true
        self.ribbon1.textColor = UIColor.blue
        self.ribbon1.fillColor = UIColor.lightGray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

