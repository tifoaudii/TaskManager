//
//  UIFactory.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

protocol UIFactory {
    func createTaskViewController(dataStore: TaskViewDataStore, navigationDelegate: TaskViewControllerNavigationDelegate) -> UIViewController
    func createAddTaskViewController(dataStore: AddTaskViewDataStore, didAddNewTask: @escaping () -> Void) -> UIViewController
}

final class ViewControllerFactory: UIFactory {
    
    func createTaskViewController(dataStore: TaskViewDataStore, navigationDelegate: TaskViewControllerNavigationDelegate) -> UIViewController {
        let presenter = TaskViewDefaultPresenter(dataStore: dataStore)
        let taskViewController = TaskViewController(presenter: presenter, navigationDelegate: navigationDelegate)
        return taskViewController
    }
    
    func createAddTaskViewController(dataStore: AddTaskViewDataStore, didAddNewTask: @escaping () -> Void) -> UIViewController {
        let presenter = AddTaskViewDefaultPresenter(dataStore: dataStore)
        let addTaskViewController = AddTaskViewController(presenter: presenter)
        
        presenter.didAddNewTask = {
            addTaskViewController.dismiss(animated: true, completion: nil)
            didAddNewTask()
        }
        
        return addTaskViewController
    }
}
