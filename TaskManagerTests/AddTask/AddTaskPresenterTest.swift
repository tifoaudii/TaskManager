//
//  AddTaskPresenterTest.swift
//  TaskManagerTests
//
//  Created by Tifo Audi Alif Putra on 17/05/22.
//

import XCTest
@testable import TaskManager

class AddTaskPresenterTest: XCTestCase {

    func test_whenAddNewTask_shouldAskDataStoreToSave() {
        let dataStore = AddTaskViewDataStoreSpy()
        let sut = AddTaskViewDefaultPresenter(dataStore: dataStore)
        
        let date = Date()
        sut.addNewTask(title: "Test Task", type: .basic, color: .blue, deadline: date)

        XCTAssertTrue(dataStore.addNewTaskCalled)
        XCTAssertEqual(dataStore.taskTitle, "Test Task")
        XCTAssertEqual(dataStore.taskType, TaskType.basic.rawValue)
        XCTAssertEqual(dataStore.taskColor!, TaskColorType.blue.color)
        XCTAssertEqual(dataStore.taskDeadline!, date)
    }
    
    func test_whenAddNewTask_shouldDispatchCallback() {
        let dataStore = AddTaskViewDataStoreSpy()
        let sut = AddTaskViewDefaultPresenter(dataStore: dataStore)
        var callbackCalled = false

        sut.didAddNewTask = {
            callbackCalled = true
        }
        
        sut.addNewTask(title: "Test Task", type: .basic, color: .blue, deadline: Date())
        XCTAssertTrue(callbackCalled)
    }
    
    func test_whenReceiveDate_shouldFormatInStringProperly() {
        let dataStore = AddTaskViewDataStoreSpy()
        let sut = AddTaskViewDefaultPresenter(dataStore: dataStore)

        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 08
        dateComponents.day = 24
        dateComponents.hour = 10
        dateComponents.minute = 0
        dateComponents.timeZone = .current
        
        let date = Calendar.current.date(from: dateComponents)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy, HH:mm"
        let dateString = sut.getFormattedDate(from: date)

        XCTAssertEqual(dateString, "08/24/2020, 10:00")
    }
    
    
    // MARK: Helper
    
    private class AddTaskViewDataStoreSpy: AddTaskViewDataStore {
        
        var addNewTaskCalled = false
        var taskTitle: String = ""
        var taskType: String = ""
        var taskColor: NSObject?
        var taskDeadline: Date?
        
        func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) {
            taskTitle = title
            taskType = type.rawValue
            taskColor = color.color
            taskDeadline = deadline
            addNewTaskCalled = true
        }
    }
}
