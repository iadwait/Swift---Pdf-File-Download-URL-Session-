//
//  PDFViewController.swift
//  File Download (URL Session)
//
//  Created by Adwait Barkale on 11/11/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfView = PDFView()
    var pdfUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pdfView)
        if let document = PDFDocument(url: pdfUrl){
            pdfView.document = document
        }
        
        //Dismiss after 3 seconds
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          //  self.dismiss(animated: true, completion: nil)
        //}
    }

    override func viewWillLayoutSubviews() {
        pdfView.frame = self.view.frame
    }
    
}
