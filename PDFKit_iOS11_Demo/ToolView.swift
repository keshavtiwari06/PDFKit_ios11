//
//  toolView.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 15/01/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit

class ToolView: UIView {
    
    @IBOutlet weak var thumbBtn: UIButton!
    @IBOutlet weak var outlineBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    class func instanceFromNib() -> ToolView {
        return UINib(nibName: "ToolView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ToolView
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        self.makeViewCornerColouredWithShadow(radius: 5, color: UIColor.black, button: thumbBtn)
        self.makeViewCornerColouredWithShadow(radius: 5, color: UIColor.black, button: outlineBtn)

    }
    
    func makeViewCornerColouredWithShadow(radius : CGFloat,color : UIColor, button: UIButton)
    {
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = radius
        button.layer.masksToBounds = true
        button.layer.borderColor = color.cgColor
        
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        button.layer.shadowRadius = radius
    }

}
