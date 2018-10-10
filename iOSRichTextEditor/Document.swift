//
//  Document.swift
//  iOSRichTextEditor
//
//  Created by mark on 7/31/18.
//  Copyright © 2018 Swift Dev Journal. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    var text: NSAttributedString? = nil
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        guard let text = text else { return Data() }
        return NSKeyedArchiver.archivedData(withRootObject: text)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        guard let data = contents as? Data else { return }
        guard let fileContents = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSAttributedString else { return }
        text = fileContents
        
    }
}

