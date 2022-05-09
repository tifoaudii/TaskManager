//
//  TaskViewPresenter.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import Foundation

protocol TaskViewPresenter {
    func fetchPresentableTask(completion: @escaping ([Task]) -> Void)
}

final class TaskViewDefaultPresenter: TaskViewPresenter {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func fetchPresentableTask(completion: @escaping ([Task]) -> Void) {
        let request = Task.fetchRequest()
        let tasks = try! coreDataStack.viewContext.fetch(request)
        completion(tasks)
    }
}
