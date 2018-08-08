//
//  OulineTableviewController.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 15/01/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit
import PDFKit

protocol ContentsDelegate: class{
    func oulineTableviewController(_ oulineTableviewController: ContentsVC,
                                   didSelectOutline outline: PDFOutline)
}

class ContentsVC: UITableViewController {
    weak var delegate: ContentsDelegate?
    
    open var pdfOutlineRoot: PDFOutline? {
        didSet{
            for index in 0...(pdfOutlineRoot?.numberOfChildren)!-1 {
                let pdfOutline = pdfOutlineRoot?.child(at: index)
                pdfOutline?.isOpen = false
                data.append(pdfOutline!)
            }
            tableView.reloadData()
        }
    }
    
    var data = [PDFOutline]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeButtonPressed))
        tableView.register(UINib(nibName: "ContentsCell", bundle: nil), forCellReuseIdentifier: "ContentsCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func closeButtonPressed(sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContentsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsCell
        
        let outline = data[indexPath.row];
        
        cell.textLbl.text = outline.label
        cell.pageNoLbl.text = outline.destination?.page?.label
        
        if outline.numberOfChildren > 0 {
            cell.expandBtn.setImage(outline.isOpen ? #imageLiteral(resourceName: "arrow_down") : #imageLiteral(resourceName: "arrow_right"), for: .normal)
            cell.expandBtn.isEnabled = true
        } else {
            cell.expandBtn.setImage(nil, for: .normal)
            cell.expandBtn.isEnabled = false
        }
        
        cell.openButtonPressed = {[weak self] (sender)-> Void in
            if outline.numberOfChildren > 0 {
                if sender.isSelected {
                    outline.isOpen = true
                    self?.insertChirchen(parent: outline)
                } else {
                    outline.isOpen = false
                    self?.removeChildren(parent: outline)
                }
                tableView.reloadData()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        let outline = data[indexPath.row];
        let depth = findDepth(outline: outline)
        return depth;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outline = data[indexPath.row]
        delegate?.oulineTableviewController(self, didSelectOutline: outline)
        dismiss(animated: false, completion: nil)
    }
    
    func findDepth(outline: PDFOutline) -> Int {
        var depth: Int = -1
        var tmp = outline
        while (tmp.parent != nil) {
            depth = depth + 1
            tmp = tmp.parent!
        }
        return depth
    }
    
    func insertChirchen(parent: PDFOutline) {
        var tmpData: [PDFOutline] = []
        let baseIndex = self.data.index(of: parent)
        for index in 0..<parent.numberOfChildren {
            let pdfOutline = parent.child(at: index)
            pdfOutline?.isOpen = false
            tmpData.append(pdfOutline!)
        }
        self.data.insert(contentsOf: tmpData, at:baseIndex! + 1)
    }
    
    func removeChildren(parent: PDFOutline) {
        if parent.numberOfChildren <= 0 {
            return
        }
        
        for index in 0..<parent.numberOfChildren {
            let node = parent.child(at: index)
            
            if node!.numberOfChildren > 0 {
                removeChildren(parent: node!)
                
                // remove self
                if let i = data.index(of: node!) {
                    data.remove(at: i)
                }
                
            } else {
                if self.data.contains(node!) {
                    if let i = data.index(of: node!) {
                        data.remove(at: i)
                    }
                }
            }
        }
    }
}


