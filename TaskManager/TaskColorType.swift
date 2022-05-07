//
//  TaskColorType.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 07/05/22.
//

import UIKit

enum TaskColorType: CaseIterable {
    case green
    case teal
    case pink
    case gray
    case blue
    
    var color: UIColor {
        switch self {
        case .green:
            return .systemGreen
        case .teal:
            return .systemTeal
        case .pink:
            return .systemPink
        case .gray:
            return .lightGray
        case .blue:
            return .systemBlue
        }
    }
}
