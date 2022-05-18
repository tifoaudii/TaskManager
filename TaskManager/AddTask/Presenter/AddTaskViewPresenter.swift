//
//  AddTaskViewPresenter.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import Foundation

protocol AddTaskViewDataStore {
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date)
}

final class AddTaskViewDefaultPresenter: AddTaskViewPresenter {
    
    private let dataStore: AddTaskViewDataStore
    
    var didAddNewTask: (() -> Void)?
    
    init(dataStore: AddTaskViewDataStore) {
        self.dataStore = dataStore
    }
    
    func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) {
        dataStore.addNewTask(title: title, type: type, color: color, deadline: deadline)
        didAddNewTask?()
    }
    
    func getFormattedDate(from date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy, HH:mm"
        return dateFormatter.string(from: date)
    }
}
