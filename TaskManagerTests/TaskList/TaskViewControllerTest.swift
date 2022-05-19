//
//  TaskViewControllerTest.swift
//  TaskManagerTests
//
//  Created by Tifo Audi Alif Putra on 19/05/22.
//

import XCTest
@testable import TaskManager

class TaskViewControllerTest: XCTestCase {

    func test_whenViewDidLoad_shouldRenderNavbarTitle() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Task Manager")
    }
    
    func test_whenViewDidLoad_shouldAskPresenterToFetchTodayTask() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(presenterSpy.fetchTaskCalled)
    }
    
    func test_whenSuccessFetchTask_shouldRenderToTableView() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        var taskSelected = false
        
        sut.loadViewIfNeeded()
        presenterSpy.fetchTaskCompletion?([
            PresentableTask(title: "Test", type: "Task Type", deadline: getSampleDate(), color: getSampleColor(), selection: {
                taskSelected = true
            })
        ])
        
        let cell = sut.tableView.cell(for: .init(row: 0, section: 0))
        cell.onTapTaskButton(self)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(cell.taskTitleLabel.text, "Test")
        XCTAssertEqual(cell.taskDeadlineDateLabel.text, "01 Jan 2020")
        XCTAssertEqual(cell.taskDeadlineTimeLabel.text, "09:00")
        XCTAssertEqual(cell.taskTypeLabel.text, "Task Type")
        XCTAssertTrue(taskSelected)
    }
    
    
    func test_whenTapTodayButton_shouldAskPresenterUpdateContentType() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        sut.onTapTodayButton(self)
        
        XCTAssertTrue(presenterSpy.fetchTaskCalled)
        XCTAssertTrue(presenterSpy.updateContentTypeCalled)
        XCTAssertEqual(presenterSpy.contentType, .today)
    }
    
    func test_whenTapUpcomingButton_shouldAskPresenterUpdateContentType() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        sut.onTapUpcomingButton(self)
        
        XCTAssertTrue(presenterSpy.fetchTaskCalled)
        XCTAssertTrue(presenterSpy.updateContentTypeCalled)
        XCTAssertEqual(presenterSpy.contentType, .upcoming)
    }
    
    func test_whenTapFailedButton_shouldAskPresenterUpdateContentType() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        sut.onTapFailedButton(self)
        
        XCTAssertTrue(presenterSpy.fetchTaskCalled)
        XCTAssertTrue(presenterSpy.updateContentTypeCalled)
        XCTAssertEqual(presenterSpy.contentType, .failed)
    }
    
    func test_whenTapDoneButton_shouldAskPresenterUpdateContentType() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        sut.onTapDoneButton(self)
        
        XCTAssertTrue(presenterSpy.fetchTaskCalled)
        XCTAssertTrue(presenterSpy.updateContentTypeCalled)
        XCTAssertEqual(presenterSpy.contentType, .done)
    }
    
    func test_whenTapAddTaskButton_shouldAskDelegateToDisplayAddTaskView() {
        let presenterSpy = TaskViewPresenterSpy()
        let navigationSpy = TaskViewNavigationSpy()
        let sut = TaskViewController(presenter: presenterSpy, navigationDelegate: navigationSpy)
        
        sut.loadViewIfNeeded()
        sut.onTapAddTaskButton(self)
        
        navigationSpy.didAddNewTaskCompletion?()
        
        XCTAssertTrue(navigationSpy.displayAddTaskCalled)
        XCTAssertNotNil(navigationSpy.didAddNewTaskCompletion)
        XCTAssertTrue(presenterSpy.fetchTaskCalled)
    }
    
    // MARK: Helper
    
    private func getSampleDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.hour = 9
        dateComponents.minute = 0
        dateComponents.timeZone = .current
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    private func getSampleColor() -> UIColor {
        TaskColorType.blue.color
    }
    
    private class TaskViewPresenterSpy: TaskViewPresenter {
        
        var contentType: TaskContentType = .today
        var fetchTaskCalled = false
        var updateContentTypeCalled = false
        var fetchTaskCompletion: (([PresentableTask]) -> Void)?
        
        func fetchTask(for contentType: TaskContentType, completion: @escaping ([PresentableTask]) -> Void) {
            fetchTaskCalled = true
            fetchTaskCompletion = completion
        }
        
        func updateContentType(with contentType: TaskContentType) {
            self.contentType = contentType
            updateContentTypeCalled = true
        }
    }
    
    private class TaskViewNavigationSpy: TaskViewControllerNavigationDelegate {
        
        var displayAddTaskCalled = false
        var didAddNewTaskCompletion: (() -> Void)?
        
        func displayAddTaskView(from viewController: UIViewController, didAddNewTask: @escaping (() -> Void)) {
            displayAddTaskCalled = true
            didAddNewTaskCompletion = didAddNewTask
        }
    }
}

private extension UITableView {
    
    func cell(for indexPath: IndexPath) -> TaskCell {
        dataSource?.tableView(self, cellForRowAt: indexPath) as! TaskCell
    }
}
