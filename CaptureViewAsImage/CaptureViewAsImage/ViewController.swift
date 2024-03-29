//
//  ViewController.swift
//  CaptureViewAsImage
//
//  Created by Rob Kerr on 1/2/21.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    @IBOutlet weak var designView: DesignView!
    @IBOutlet weak var emailAddress: UITextField!

    @IBAction func changeSegmentCount(_ sender: UISlider) {
        designView.numberOfEllipses = Int(sender.value * 2)
    }
    
    @IBAction func changeSegmentColor(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: designView.color = UIColor.systemPurple
            case 1: designView.color = UIColor.systemBlue
            case 2: designView.color = UIColor.systemRed
            default: designView.color = UIColor.systemOrange
        }
    }
    
    @IBAction func sendEmailTapped(_ sender: UIButton) {
        if let addr = emailAddress.text, !addr.isEmpty,
           let jpegData = designView.asJpeg,
           MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["\(addr)"])
            mail.setSubject("Design attached")
            mail.setMessageBody("Here's my cool design attached!", isHTML: true)
            mail.mailComposeDelegate = self
            mail.addAttachmentData(jpegData, mimeType: "image/jpeg" , fileName: "mydesign.jpeg")
            let ismain = Thread.isMainThread
            print("Are we on main thread already? \(ismain)")
            DispatchQueue.main.async {
                self.present(mail, animated: true)
            }

        }
        else {
            print("Email cannot be sent")
        }
    }
    
    @IBAction func textFieldDidEndOnExit(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    @IBAction func SaveImageTapped(_ sender: UIButton) {
        if let jpegData = designView.asJpeg {
            let filename = UUID().uuidString + ".jpg"
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docDirectoryPath = paths[0]
            let filePath = docDirectoryPath.appendingPathComponent(filename)
            let success = FileManager.default.createFile(atPath: filePath.path, contents: jpegData, attributes: nil)
            showAlert(title: success ? "Success" : "Failed", message: filePath.path)
            print(filePath.path)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}


extension UIView {
    var asJpeg: Data? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
        return image.jpegData(compressionQuality: 0.8)
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            self.dismiss(animated: true, completion: nil)
        }
        switch result {
            case .cancelled:
                print("Cancelled")
                break
            case .sent:
                print("Mail sent successfully")
                break
            case .failed:
                print("Sending mail failed")
                break
            default:
                break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


