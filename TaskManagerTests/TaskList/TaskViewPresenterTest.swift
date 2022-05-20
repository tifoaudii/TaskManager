//
//  TaskViewPresenterTest.swift
//  TaskManagerTests
//
//  Created by Tifo Audi Alif Putra on 18/05/22.
//

@testable import TaskManager
import XCTest

class TaskViewPresenterTest: XCTestCase {

    func test_whenGetContentType_shouldChangeContentType() {
        let dataStore = TaskViewDataStoreSpy()
        let sut = TaskViewDefaultPresenter(dataStore: dataStore)
        let contentType = TaskContentType.upcoming
        
        sut.updateContentType(with: contentType)
        XCTAssertEqual(sut.contentType, contentType)
    }

    
    func test_whenContentTypeIsTodayTask_shouldFetchTodayTask() {
        let dataStore = TaskViewDataStoreSpy()
        let sut = TaskViewDefaultPresenter(dataStore: dataStore)
        let contentType = TaskContentType.today
        var presentableTask: PresentableTask?
        
        sut.updateContentType(with: contentType)
        sut.fetchTask(for: contentType) { tasks in
            XCTAssertEqual(tasks.count, 1)
            presentableTask = tasks.first!
        }
        
        dataStore.todayTaskCompletion?([
            TaskModel(title: "Today Task", type: "Urgent", deadline: Date(), color: TaskColorType.blue.color, isCompleted: false)
        ])
        
        XCTAssertTrue(dataStore.fetchTodayTaskCalled)
        
        presentableTask?.selection()
        XCTAssertTrue(dataStore.finishTaskCalled)
    }
    
    func test_whenContentTypeIsUpcomingTask_shouldFetchTodayTask() {
        let dataStore = TaskViewDataStoreSpy()
        let sut = TaskViewDefaultPresenter(dataStore: dataStore)
        let contentType = TaskContentType.upcoming
        
        sut.updateContentType(with: contentType)
        sut.fetchTask(for: contentType) { tasks in
            XCTAssertEqual(tasks.count, 1)
        }
        
        dataStore.upcomingTaskCompletion?([
            TaskModel(title: "Upcoming Task", type: "Urgent", deadline: Date(), color: TaskColorType.blue.color, isCompleted: false)
        ])
        
        XCTAssertTrue(dataStore.fetchUpcomingTaskCalled)
    }
    
    func test_whenContentTypeIsFailedTask_shouldFetchTodayTask() {
        let dataStore = TaskViewDataStoreSpy()
        let sut = TaskViewDefaultPresenter(dataStore: dataStore)
        let contentType = TaskContentType.failed
        
        sut.updateContentType(with: contentType)
        sut.fetchTask(for: contentType) { tasks in
            XCTAssertEqual(tasks.count, 1)
        }
        
        dataStore.failedTaskCompletion?([
            TaskModel(title: "Failed Task", type: "Urgent", deadline: Date(), color: TaskColorType.blue.color, isCompleted: false)
        ])
        
        XCTAssertTrue(dataStore.fetchFailedTaskCalled)
    }
    
    func test_whenContentTypeIsFinishedTask_shouldFetchTodayTask() {
        let dataStore = TaskViewDataStoreSpy()
        let sut = TaskViewDefaultPresenter(dataStore: dataStore)
        let contentType = TaskContentType.done
        
        sut.updateContentType(with: contentType)
        sut.fetchTask(for: contentType) { tasks in
            XCTAssertEqual(tasks.count, 1)
        }
        
        dataStore.finishedTaskCompletion?([
            TaskModel(title: "Finished Task", type: "Urgent", deadline: Date(), color: TaskColorType.blue.color, isCompleted: false)
        ])
        
        XCTAssertTrue(dataStore.fetchFinishedTaskCalled)
    }
    
    // MARK: Helper
    private class TaskViewDataStoreSpy: TaskViewDataStore {

        var fetchTodayTaskCalled = false
        var fetchFailedTaskCalled = false
        var fetchUpcomingTaskCalled = false
        var fetchFinishedTaskCalled = false
        var finishTaskCalled = false
        
        var todayTaskCompletion: (([TaskModel]) -> Void)?
        var failedTaskCompletion: (([TaskModel]) -> Void)?
        var upcomingTaskCompletion: (([TaskModel]) -> Void)?
        var finishedTaskCompletion: (([TaskModel]) -> Void)?
        
        func fetchTodayTask(completion: @escaping ([TaskModel]) -> Void) {
            fetchTodayTaskCalled = true
            todayTaskCompletion = completion
        }
        
        func fetchFailedTask(completion: @escaping ([TaskModel]) -> Void) {
            fetchFailedTaskCalled = true
            failedTaskCompletion = completion
        }
        
        func fetchUpcomingTask(completion: @escaping ([TaskModel]) -> Void) {
            fetchUpcomingTaskCalled = true
            upcomingTaskCompletion = completion
        }
        
        func fetchFinishedTask(completion: @escaping ([TaskModel]) -> Void) {
            fetchFinishedTaskCalled = true
            finishedTaskCompletion = completion
        }
        
        func finishTask(_ task: TaskModel) {
            finishTaskCalled = true
        }
    }
}
