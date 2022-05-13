//
//  PresentableTask.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

struct PresentableTask {
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var taskType: String {
        task.type ?? ""
    }
    
    var taskTitle: String {
        task.title ?? ""
    }
    
    var taskDeadlineDate: String {
//        if let deadline = task.deadline, let deadlineDate = deadline.split(separator: ",").first {
//            return String(deadlineDate)
//        }
//
        return ""
    }
    
    var taskDeadlineTime: String {
//        if let deadline = task.deadline, let deadlineTime = deadline.split(separator: ",").last {
//            return String(deadlineTime)
//        }
//        
        return ""
    }
    
    var taskColor: UIColor {
        if let transformableColor = task.color, let color = transformableColor as? UIColor {
            return color
        }
        
        return .clear
    }
}
