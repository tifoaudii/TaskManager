//
//  AddTaskPresenterTest.swift
//  TaskManagerTests
//
//  Created by Tifo Audi Alif Putra on 17/05/22.
//

import XCTest
@testable import TaskManager

class AddTaskPresenterTest: XCTestCase {

    func test_whenAddNewTask_shouldAskCoreDataToSave() {
        let coreDataStack = CoreDataStack(inMemory: true)
        let sut = AddTaskViewDefaultPresenter(coreDataStack: coreDataStack)
        
        let date = Date()
        let task = sut.addNewTask(title: "Test Task", type: .basic, color: .blue, deadline: date)

        XCTAssertNotNil(task)
        XCTAssertEqual(task.title, "Test Task")
        XCTAssertEqual(task.type, TaskType.basic.rawValue)
        XCTAssertEqual(task.color, TaskColorType.blue.color)
        XCTAssertEqual(task.deadline, date)
    }
    
    func test_whenAddNewTask_shouldDispatchCallback() {
        let coreDataStack = CoreDataStack(inMemory: true)
        let sut = AddTaskViewDefaultPresenter(coreDataStack: coreDataStack)
        var callbackCalled = false
        
        sut.didAddNewTask = {
            callbackCalled = true
        }
        let date = Date()
        sut.addNewTask(title: "Test Task", type: .basic, color: .blue, deadline: date)
        
        XCTAssertTrue(callbackCalled)
    }
    
    func test_whenReceiveDate_shouldFormatInStringProperly() {
        let coreDataStack = CoreDataStack(inMemory: true)
        let sut = AddTaskViewDefaultPresenter(coreDataStack: coreDataStack)
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy, HH:mm"
        let dateString = sut.getFormattedDate(from: date)
        
        XCTAssertEqual(dateString, dateFormatter.string(from: date))
    }
}
