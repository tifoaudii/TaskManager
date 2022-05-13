//
//  AddTaskViewPresenter.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import Foundation

protocol AddTaskViewPresenter {
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date)
}

final class AddTaskViewDefaultPresenter: AddTaskViewPresenter {
    
    private let coreDataStack: CoreDataStack
    
    var didAddNewTask: (() -> Void)?
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) {
        let newTask = Task(context: coreDataStack.viewContext)
        newTask.color = color.color
        newTask.deadline = deadline
        newTask.title = title
        newTask.type = type.rawValue
        coreDataStack.save()
        didAddNewTask?()
    }
}
