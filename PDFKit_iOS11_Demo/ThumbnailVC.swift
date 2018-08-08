//
//  ThumbnailGridViewController.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 15/01/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit
import PDFKit

protocol ThumbnailDelegate: class{
    func thumbnailViewController(_ thumbnailGridViewController: ThumbnailVC, didSelectPage page: PDFPage)
}

class ThumbnailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    open var pdfDocument: PDFDocument?
    weak var delegate: ThumbnailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(closeBtnClick(sender:)))
        
        // Register cell classes
        collectionView?.register(UINib(nibName: "ThumbnailCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ThumbnailCell")
        
        
        collectionView?.backgroundColor = UIColor.gray
    }
    
    @objc func closeBtnClick(sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}

extension ThumbnailVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfDocument?.pageCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCell", for: indexPath) as! ThumbnailCell
        
        if let page = pdfDocument?.page(at: indexPath.item) {
            let thumbnail = page.thumbnail(of: cell.bounds.size, for: PDFDisplayBox.cropBox)
            cell.image = thumbnail
            
            cell.pageLab.text = page.label
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let page = pdfDocument?.page(at: indexPath.item) {
            dismiss(animated: false, completion: nil)
            delegate?.thumbnailViewController(self, didSelectPage: page)
        }
    }
}
