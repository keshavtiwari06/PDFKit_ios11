//
//  MyVC.swift
//  PDFKit_iOS11_Demo
//
//  Created by Keshav Tiwari on 27/07/18.
//  Copyright © 2018 Keshav Tiwari. All rights reserved.
//

import UIKit

class MyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openPdfPressed(_ sender: UIButton) {
        
        let obj = ViewController()
        myPdfDocumentName = "Introduction_to_Adobe_Acrobat_XI_Pro"
        self.present(obj, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
