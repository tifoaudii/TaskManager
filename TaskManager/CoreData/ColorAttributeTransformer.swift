//
//  ColorAttributeTransformer.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

final class ColorAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] {
        [UIColor.self]
    }
    
    static func register() {
        let className = String(describing: ColorAttributeTransformer.self)
        let name = NSValueTransformerName(className)
        
        let transformer = ColorAttributeTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

