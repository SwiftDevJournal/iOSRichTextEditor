//
//  Document.swift
//  iOSRichTextEditor
//
//  Created by mark on 7/31/18.
//  Copyright © 2018 Me and Mark Publishing. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

