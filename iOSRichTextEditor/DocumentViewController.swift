//
//  DocumentViewController.swift
//  iOSRichTextEditor
//
//  Created by mark on 7/31/18.
//  Copyright © 2018 Me and Mark Publishing. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForNotifications()
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.textView.attributedText = self.document?.text
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(DocumentViewController.keyboardWasShown(notification:)), name:UIResponder.keyboardDidShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(DocumentViewController.keyboardWillBeHidden(notification:)), name:UIResponder.keyboardWillHideNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DocumentViewController.preferredContentSizeChanged(notification:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        document?.text = textView.attributedText
        document?.updateChangeCount(.done)
    }
    
    // Notification handling functions
    @objc func keyboardWasShown(notification: NSNotification) {
        // Scroll the text view so the keyboard doesn't block what's being typed.
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            let keyboardSize = keyboardRect.size
            textView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.scrollIndicatorInsets = textView.contentInset
    }
    
    @objc func preferredContentSizeChanged(notification: NSNotification) {
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
}
