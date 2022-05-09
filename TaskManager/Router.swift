//
//  Router.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

protocol Router {
    func pushToTaskView()
    func presentAddTaskView(from viewController: UIViewController, didAddNewTask: @escaping (() -> Void))
}

final class AppRouter: Router, TaskViewControllerNavigationDelegate {
    
    private let navigationController: UINavigationController
    private let factory: UIFactory
    
    init(navigationController: UINavigationController, factory: UIFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func pushToTaskView() {
        let taskViewController = factory.createTaskViewController(navigationDelegate: self)
        navigationController.pushViewController(taskViewController, animated: true)
    }
    
    func presentAddTaskView(from viewController: UIViewController, didAddNewTask: @escaping (() -> Void)) {
        let addTaskViewController = factory.createAddTaskViewController(didAddNewTask: didAddNewTask)
        viewController.present(addTaskViewController, animated: true, completion: nil)
    }
    
    func displayAddTaskView(from viewController: UIViewController, didAddNewTask: @escaping (() -> Void)) {
        presentAddTaskView(from: viewController, didAddNewTask: didAddNewTask)
    }
}
