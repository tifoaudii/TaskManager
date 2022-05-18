//
//  AddTaskViewPresenter.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import Foundation

protocol AddTaskViewPresenter {
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) -> Task
    func getFormattedDate(from date: Date) -> String
}

final class AddTaskViewDefaultPresenter: AddTaskViewPresenter {
    
    private let coreDataStack: CoreDataStack
    
    var didAddNewTask: (() -> Void)?
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    @discardableResult
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) -> Task {
        let newTask = Task(context: coreDataStack.viewContext)
        newTask.color = color.color
        newTask.deadline = deadline
        newTask.title = title
        newTask.type = type.rawValue
        coreDataStack.save()
        didAddNewTask?()
        return newTask
    }
    
    func getFormattedDate(from date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy, HH:mm"
        return dateFormatter.string(from: date)
    }
}
