//
//  AddTaskViewControllerTest.swift
//  TaskManagerTests
//
//  Created by Tifo Audi Alif Putra on 18/05/22.
//

@testable import TaskManager
import XCTest

class AddTaskViewControllerTest: XCTestCase {

    func test_whenViewDidLoad_shouldLoadInputViewToDeadlineTextField() {
        let presenter = AddTaskPresenterSpy()
        let sut = AddTaskViewController(presenter: presenter)
        
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.deadlineTaskField.inputView)
    }
    
    func test_whenSelectDate_shouldRenderCorrectDateFormatToTextField() {
        let presenter = AddTaskPresenterSpy()
        let sut = AddTaskViewController(presenter: presenter)
        let date = Date()
        
        sut.loadViewIfNeeded()
        sut.datePicker.date = date
        sut.didSelectDate(sut.datePicker)
        
        XCTAssertTrue(presenter.getFormattedDateCalled)
        XCTAssertEqual(sut.deadlineTaskField.text, presenter.getFormattedDate(from: date))
    }
    
    func test_whenTapSaveButton_shouldSaveNewTask() {
        let presenter = AddTaskPresenterSpy()
        let sut = AddTaskViewController(presenter: presenter)
        
        sut.loadViewIfNeeded()
        sut.deadlineTaskField.text = "some date"
        sut.titleTaskField.text = "title"
        sut.onTapSaveButton(sut.saveButton!)
        
        XCTAssertTrue(presenter.addNewTaskCalled)
    }
    
    func test_whenSubmissionNotCompleted_shouldNotSaveTask() {
        let presenter = AddTaskPresenterSpy()
        let sut = AddTaskViewController(presenter: presenter)
        
        sut.loadViewIfNeeded()
        sut.deadlineTaskField.text = "some date"
        sut.onTapSaveButton(sut.saveButton!)
        
        XCTAssertFalse(presenter.addNewTaskCalled)
    }
    
    // MARK: Helper
    
    private class AddTaskPresenterSpy: AddTaskViewPresenter {
        
        var addNewTaskCalled = false
        var getFormattedDateCalled = false
        
        func addNewTask(title: String, type: TaskType, color: TaskColorType, deadline: Date) {
            addNewTaskCalled = true
        }
        
        func getFormattedDate(from date: Date) -> String {
            getFormattedDateCalled = true
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyy, HH:mm"
            return dateFormatter.string(from: date)
        }
    }
}
