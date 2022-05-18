//
//  CoreData+AddTaskViewDataStore.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 18/05/22.
//

import Foundation

extension CoreDataStack: AddTaskViewDataStore {
    
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) {
        let newTask = Task(context: viewContext)
        newTask.color = color.color
        newTask.deadline = deadline
        newTask.title = title
        newTask.type = type.rawValue
        save()
    }
}
