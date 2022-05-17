//
//  PresentableTask.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

struct PresentableTask {
    
    private let title: String?
    private let type: String?
    private let deadline: Date?
    private let color: NSObject?
    
    let selection: () -> Void
    
    init(
        title: String?,
        type: String?,
        deadline: Date?,
        color: NSObject?,
        selection: @escaping () -> Void
    ) {
        self.title = title
        self.type = type
        self.deadline = deadline
        self.color = color
        self.selection = selection
    }

    var taskType: String {
        type ?? ""
    }
    
    var taskTitle: String {
        title ?? ""
    }
    
    var taskDeadlineDate: String {
        guard let date = deadline else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var taskDeadlineTime: String {
        guard let date = deadline else {
            return ""
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var taskColor: UIColor {
        if let transformableColor = color, let color = transformableColor as? UIColor {
            return color
        }
        
        return .clear
    }
}
