//
//  AppFlow.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import Foundation

final class AppFlow {
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        router.pushToTaskView()
    }
}
