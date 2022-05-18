//
//  TaskModel.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 18/05/22.
//

import Foundation

protocol TaskModelConvertible {
    func asTaskModel() -> TaskModel
}

struct TaskModel {
    let title: String
    let type: String
    let deadline: Date
    let color: NSObject?
    let isCompleted: Bool
}
