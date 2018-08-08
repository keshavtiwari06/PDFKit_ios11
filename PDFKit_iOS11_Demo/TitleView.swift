//
//  TitleView.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 15/01/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    class func instanceFromNib() -> TitleView {
        return UINib(nibName: "TitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleView
    }
    
    override func draw(_ rect: CGRect) {
        
        makeViewCornerColouredWithShadow(radius: 5, label: titleLabel)
        
    }
 
    func makeViewCornerColouredWithShadow(radius : CGFloat, label: UILabel)
    {
        label.layer.borderWidth = 0.5
        label.layer.cornerRadius = radius
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        
        label.layer.shadowColor = UIColor.lightGray.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        label.layer.shadowRadius = radius
        
    }

}
