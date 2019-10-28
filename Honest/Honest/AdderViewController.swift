//
//  ViewController.swift
//  Honest
//
//  Created by Arthur Goldblatt on 10/25/19.
//  Copyright © 2019 Arthur Goldblatt. All rights reserved.
//

import UIKit
import PDFKit

class AdderViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var quant: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        guard let text = quant.text, let number = Int(text) else {
            return
        }
        
        var authCodes = Array(repeating : "", count: number)
        var qrcodes : [UIImage] = []
    
        for i in 0..<number {
            let code = randomString(length: 64)
            authCodes[i] = code
            let qrcode = generateQRCode(from: code)
            qrcodes.append(qrcode!)
        }
            
        createPDFDataFromImage(images: qrcodes)
    
    }
    
    
    func configureTextFields() {
        name.delegate = self
        quant.delegate = self
    }
    
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
//    func writePDF(images: [UIImage]) {
//
//        let pageRect = CGRect(x: 0, y: 0, width: 4 * 72.0, height: 4 * 72.0)
//        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
//
//        var i = 0
//
//       let data = renderer.pdfData { ctx in
//            ctx.beginPage()
//
//            images[i].draw(in: pageRect.insetBy(dx: 50, dy: 50))
//            i = i + 1
//        }
    
    func createPDFDataFromImage(images: [UIImage]) {
        let pdfData = NSMutableData()
        let imageRect = CGRect(x: 0, y: 0, width: images[0].size.width, height: images[0].size.height)
        
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        
        for i in 0..<images.count {
            let imgView = UIImageView.init(image: images[i])
            UIGraphicsBeginPDFPage()
            let context = UIGraphicsGetCurrentContext()
            imgView.layer.render(in: context!)
        }
        
        
        UIGraphicsEndPDFContext()
        
        let temporaryFolder = FileManager.default.temporaryDirectory
        let fileName = name.text! + ".pdf"
        let temporaryFileURL = temporaryFolder.appendingPathComponent(fileName)
        
        print(temporaryFileURL.path)
        
        do {
            try pdfData.write(to: temporaryFileURL)
            // your code
            let activityViewController = UIActivityViewController(activityItems: [temporaryFileURL], applicationActivities: nil)
            present(activityViewController, animated: true)
                        
        } catch {
            print(error)
        }
            }
    
//    // the only one that work
//    func sendJson(code: String, name: String){
//
//
//        let request = NSMutableURLRequest(url: NSURL(string: "localhost/index.php")! as URL)
//        request.httpMethod = "POST"
//        let postString = "Code=\(code)&Name=\(name)"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//
//            print("response = \(response)")
//
//            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("responseString = \(responseString)")
//        }
//        task.resume()
//    }
        
}




extension AdderViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true

    }
}

