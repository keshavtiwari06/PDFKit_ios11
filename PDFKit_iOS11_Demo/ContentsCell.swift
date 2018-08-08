//
//  OulineTableViewCell.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 15/01/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit

class ContentsCell: UITableViewCell {

    @IBOutlet weak var leftOffset: NSLayoutConstraint!
    @IBOutlet open weak var expandBtn: UIButton!
    @IBOutlet open weak var textLbl: UILabel!
    @IBOutlet weak var pageNoLbl: UILabel!
    
    var openButtonPressed:((_ sender: UIButton) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if indentationLevel == 0 {
            textLbl.font = UIFont.systemFont(ofSize: 17 )
        } else {
            textLbl.font = UIFont.systemFont(ofSize: 15)
        }
        leftOffset.constant = CGFloat(indentationWidth * CGFloat(indentationLevel))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func openButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        openButtonPressed?(sender)
    }
    
}
