//
//  TaskViewPresenter.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import Foundation

enum TaskContentType {
    case today
    case upcoming
    case failed
    case done
}

protocol TaskViewPresenter {
    var contentType: TaskContentType { get }
    
    func fetchTask(for contentType: TaskContentType, completion: @escaping ([PresentableTask]) -> Void)
    func updateContentType(with contentType: TaskContentType)
}

final class TaskViewDefaultPresenter: TaskViewPresenter {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    var contentType: TaskContentType = .today
    
    func updateContentType(with contentType: TaskContentType) {
        self.contentType = contentType
    }
    
    func fetchTask(for contentType: TaskContentType, completion: @escaping ([PresentableTask]) -> Void) {
        let request = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Task.deadline), ascending: true)
        
        switch contentType {
        case .today:
            let startDate = Date()
            let endDate = Calendar.current.date(
                bySettingHour: 23,
                minute: 59,
                second: 59,
                of: startDate) ?? Date()
            
            let predicate = NSPredicate(format: "deadline >= %@ AND deadline < %@ AND isCompleted == %i", argumentArray: [startDate, endDate, 0])
            request.predicate = predicate
        case .upcoming:
            let startDate = Calendar.current.startOfDay(
                for: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
            )
            
            let predicate = NSPredicate(
                format: "deadline >= %@ AND isCompleted == %i",
                argumentArray: [startDate, 0]
            )
            
            request.predicate = predicate
        case .failed:
            let predicate = NSPredicate(
                format: "deadline < %@ AND isCompleted == %i",
                argumentArray: [Date(), 0]
            )
            
            request.predicate = predicate
        case .done:
            let predicate = NSPredicate(format: "isCompleted == %i", argumentArray: [1])
            request.predicate = predicate
        }
        
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let tasks = try coreDataStack.viewContext.fetch(request)
            completion(
                tasks.map { task in
                    PresentableTask(title: task.title, type: task.type, deadline: task.deadline, color: task.color) { [weak self] in
                        task.isCompleted = true
                        self?.coreDataStack.save()
                    }
                }
            )
        } catch {
            print(error)
        }
    }
    
}
