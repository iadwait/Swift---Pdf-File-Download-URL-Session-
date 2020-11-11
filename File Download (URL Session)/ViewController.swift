//
//  ViewController.swift
//  File Download (URL Session)
//
//  Created by Adwait Barkale on 11/11/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pdfUrl: URL?
    @IBOutlet weak var btnOpenFile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOpenFile.isUserInteractionEnabled = false
    }

    @IBAction func btnDownloadFileTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    @IBAction func btnOpenFileTapped(_ sender: UIButton) {
        let pdfVC = PDFViewController()
        pdfVC.pdfUrl = pdfUrl
        present(pdfVC,animated: true, completion: nil)
    }
    

}

extension ViewController: URLSessionDownloadDelegate{
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("File Downloaded at Location \(location)")
        guard let url = downloadTask.originalRequest?.url else { return }
        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationPath = docsPath.appendingPathComponent(url.lastPathComponent)
        
        try? FileManager.default.removeItem(at: destinationPath)
        do{
            try FileManager.default.copyItem(at: location, to: destinationPath)
            self.pdfUrl = destinationPath
            print("Copy File Success")
            DispatchQueue.main.async {
                self.btnOpenFile.layer.borderColor = UIColor.black.cgColor
                self.btnOpenFile.layer.borderWidth = 1
                self.btnOpenFile.isUserInteractionEnabled = true
            }
        }catch let err{
            print("Erro copying file \(err.localizedDescription)")
        }
    }
}
