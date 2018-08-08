//
//  ViewController.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 15/01/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit
import PDFKit

var myPdfDocumentName : String = ""

class ViewController: UIViewController {
    
    var myDocument: PDFDocument?
    let toolView = ToolView.instanceFromNib()
    let titleView = TitleView.instanceFromNib()
    var pdfView: PDFView!
    var thumbnailView: PDFThumbnailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.frame = CGRect(x: 10, y: 5, width: self.view.frame.width - 20, height: 70)
        titleView.titleLabel.text = myPdfDocumentName
        toolView.frame = CGRect(x: 10, y: view.frame.height - 75, width: self.view.frame.width - 20, height: 55)
        
        pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        if let url = Bundle.main.url(forResource: myPdfDocumentName, withExtension: "pdf"){
            myDocument = PDFDocument(url: url)
        }
        
        pdfView.document = myDocument
        pdfView.displayMode = PDFDisplayMode.singlePageContinuous
        pdfView.autoScales = true
        self.view.addSubview(pdfView)
        self.view.addSubview(titleView)
        self.view.addSubview(toolView)
        titleView.bringSubview(toFront: self.view)
        toolView.bringSubview(toFront: self.view)
        
        toolView.thumbBtn.addTarget(self, action: #selector(thumbnailButtonPressed), for: .touchUpInside)
        toolView.outlineBtn.addTarget(self, action: #selector(outlineBtnPressed), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Button Actions
    
    @objc func tapGestureAction(_ gestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.toolView.alpha = 1 - (self?.toolView.alpha)!
            self?.titleView.alpha = 1 - (self?.titleView.alpha)!
        }
    }
    
    @objc func thumbnailButtonPressed(sender: UIButton!) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
        let width = (view.frame.width - 10 * 4) / 3
        let height = width * 1.5
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        let thumbnailGridVC = ThumbnailVC(collectionViewLayout: layout)
        thumbnailGridVC.pdfDocument = myDocument
        thumbnailGridVC.delegate = self
        
        let nav = UINavigationController(rootViewController: thumbnailGridVC)
        self.present(nav, animated: false, completion:nil)
    }
    
    @objc func outlineBtnPressed(sender: UIButton) {
        
        if let pdfoutline = myDocument?.outlineRoot {
            let outlineVC = ContentsVC(style: UITableViewStyle.plain)
            outlineVC.pdfOutlineRoot = pdfoutline
            outlineVC.delegate = self
            
            let nav = UINavigationController(rootViewController: outlineVC)
            self.present(nav, animated: false, completion:nil)
        }
    }
}

// MARK: - All Extensions

extension ViewController: ContentsDelegate {
    func oulineTableviewController(_ oulineTableviewController: ContentsVC, didSelectOutline outline: PDFOutline) {
        let action = outline.action
        if let actiongoto = action as? PDFActionGoTo {
            pdfView.go(to: actiongoto.destination)
        }
    }
}

extension ViewController: ThumbnailDelegate {
    func thumbnailViewController(_ thumbnailGridViewController: ThumbnailVC, didSelectPage page: PDFPage) {
        pdfView.go(to: page)
    }
}




