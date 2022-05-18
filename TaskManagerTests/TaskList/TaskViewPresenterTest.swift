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
        
        sut.updateContentType(with: contentType)
        sut.fetchTask(for: contentType) { _ in }
        XCTAssertTrue(dataStore.fetchTodayTaskCalled)
    }
    
    // MARK: Helper
    private class TaskViewDataStoreSpy: TaskViewDataStore {

        var fetchTodayTaskCalled = false
        var fetchFailedTaskCalled = false
        var fetchUpcomingTaskCalled = false
        var fetchFinishedTaskCalled = false
        var finishTaskCalled = false
        
        var todayTaskCompletion: (([Task]) -> Void)?
        
        func fetchTodayTask(completion: @escaping ([Task]) -> Void) {
            fetchTodayTaskCalled = true
            todayTaskCompletion = completion
        }
        
        func fetchFailedTask(completion: @escaping ([Task]) -> Void) {
            fetchFailedTaskCalled = true
        }
        
        func fetchUpcomingTask(completion: @escaping ([Task]) -> Void) {
            fetchUpcomingTaskCalled = true
        }
        
        func fetchFinishedTask(completion: @escaping ([Task]) -> Void) {
            fetchFinishedTaskCalled = true
        }
        
        func finishTask(_ task: Task) {
            finishTaskCalled = true
        }
    }
}
