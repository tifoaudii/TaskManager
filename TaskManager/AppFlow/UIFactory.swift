//
//  UIFactory.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

protocol UIFactory {
    func createTaskViewController(navigationDelegate: TaskViewControllerNavigationDelegate) -> UIViewController
    func createAddTaskViewController(didAddNewTask: @escaping () -> Void) -> UIViewController
}

final class ViewControllerFactory: UIFactory {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func createTaskViewController(navigationDelegate: TaskViewControllerNavigationDelegate) -> UIViewController {
        let presenter = TaskViewDefaultPresenter(dataStore: coreDataStack)
        let taskViewController = TaskViewController(presenter: presenter, navigationDelegate: navigationDelegate)
        return taskViewController
    }
    
    func createAddTaskViewController(didAddNewTask: @escaping () -> Void) -> UIViewController {
        let presenter = AddTaskViewDefaultPresenter(dataStore: coreDataStack)
        let addTaskViewController = AddTaskViewController(presenter: presenter)
        
        presenter.didAddNewTask = {
            addTaskViewController.dismiss(animated: true, completion: nil)
            didAddNewTask()
        }
        
        return addTaskViewController
    }
}
