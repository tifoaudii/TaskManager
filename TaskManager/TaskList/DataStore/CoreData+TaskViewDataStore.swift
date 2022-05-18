//
//  CoreData+TaskViewDataStore.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 18/05/22.
//

import Foundation
import CoreData

extension CoreDataStack: TaskViewDataStore {
    
    func fetchTodayTask(completion: @escaping ([TaskModel]) -> Void) {
        let request = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Task.deadline), ascending: true)
        
        let startDate = Date()
        let endDate = Calendar.current.date(
            bySettingHour: 23,
            minute: 59,
            second: 59,
            of: startDate) ?? Date()

        let predicate = NSPredicate(format: "deadline >= %@ AND deadline < %@ AND isCompleted == %i", argumentArray: [startDate, endDate, 0])
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        guard let tasks = fetchRequest(request) else {
            return
        }
        
        completion(tasks.map { $0.asTaskModel()} )
    }
    
    func fetchFailedTask(completion: @escaping ([TaskModel]) -> Void) {
        let request = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Task.deadline), ascending: true)
        
        let predicate = NSPredicate(
            format: "deadline < %@ AND isCompleted == %i",
            argumentArray: [Date(), 0]
        )

        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        guard let tasks = fetchRequest(request) else {
            return
        }
        
        completion(tasks.map { $0.asTaskModel()} )
    }
    
    func fetchFinishedTask(completion: @escaping ([TaskModel]) -> Void) {
        let request = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Task.deadline), ascending: true)
        let predicate = NSPredicate(format: "isCompleted == %i", argumentArray: [1])
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        guard let tasks = fetchRequest(request) else {
            return
        }
        
        completion(tasks.map { $0.asTaskModel()} )
    }
    
    func fetchUpcomingTask(completion: @escaping ([TaskModel]) -> Void) {
        let request = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Task.deadline), ascending: true)
        let startDate = Calendar.current.startOfDay(
            for: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        )

        let predicate = NSPredicate(
            format: "deadline >= %@ AND isCompleted == %i",
            argumentArray: [startDate, 0]
        )

        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        guard let tasks = fetchRequest(request) else {
            return
        }
        
        completion(tasks.map { $0.asTaskModel()} )
    }
    
    func finishTask(_ task: TaskModel) {
        let request = Task.fetchRequest()
        let predicate = NSPredicate(format: "title == %@", task.title)
        request.predicate = predicate
        
        guard let task = try? viewContext.fetch(request).first else {
            fatalError()
        }
        
        task.isCompleted = true
        save()
    }
    
    private func fetchRequest(_ request: NSFetchRequest<Task>) -> [Task]? {
        let tasks = try? viewContext.fetch(request)
        return tasks
    }
}
