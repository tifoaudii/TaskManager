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

protocol TaskViewDataStore {
    func fetchTodayTask(completion: @escaping ([TaskModel]) -> Void)
    func fetchFailedTask(completion: @escaping ([TaskModel]) -> Void)
    func fetchUpcomingTask(completion: @escaping ([TaskModel]) -> Void)
    func fetchFinishedTask(completion: @escaping ([TaskModel]) -> Void)
    func finishTask(_ task: TaskModel)
}

final class TaskViewDefaultPresenter: TaskViewPresenter {
    
    private let dataStore: TaskViewDataStore
    
    init(dataStore: TaskViewDataStore) {
        self.dataStore = dataStore
    }
    
    var contentType: TaskContentType = .today
    
    func updateContentType(with contentType: TaskContentType) {
        self.contentType = contentType
    }
    
    func fetchTask(for contentType: TaskContentType, completion: @escaping ([PresentableTask]) -> Void) {
        switch contentType {
        case .today:
            dataStore.fetchTodayTask { [weak self] tasks in
                if let presentableTasks = self?.createPresentableTask(from: tasks) {
                    completion(presentableTasks)
                }
            }
        case .upcoming:
            dataStore.fetchUpcomingTask { [weak self] tasks in
                if let presentableTasks = self?.createPresentableTask(from: tasks) {
                    completion(presentableTasks)
                }
            }
        case .failed:
            dataStore.fetchFailedTask { [weak self] tasks in
                if let presentableTasks = self?.createPresentableTask(from: tasks) {
                    completion(presentableTasks)
                }
            }
        case .done:
            dataStore.fetchFinishedTask { [weak self] tasks in
                if let presentableTasks = self?.createPresentableTask(from: tasks) {
                    completion(presentableTasks)
                }
            }
        }
    }
    
    private func createPresentableTask(from tasks: [TaskModel]) -> [PresentableTask] {
        return tasks.map { task in
            PresentableTask(
                title: task.title,
                type: task.type,
                deadline: task.deadline,
                color: task.color) { [weak self] in
                    self?.dataStore.finishTask(task)
                }
        }
    }
}
