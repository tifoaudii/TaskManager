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
        let coreData = CoreDataStack(inMemory: true)
        let sut = TaskViewDefaultPresenter(coreDataStack: coreData)
        let contentType = TaskContentType.upcoming
        
        sut.updateContentType(with: contentType)
        XCTAssertEqual(sut.contentType, contentType)
    }

    
    func test_whenFetchTask_shouldCreatePresentableTask() {
        let coreData = CoreDataStack(inMemory: true)
        let sut = TaskViewDefaultPresenter(coreDataStack: coreData)
    }
}
