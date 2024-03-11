//
//  ToDoListRepositoryTests.swift
//  ToDoSharedTests
//
//  Created by Pankaj Sachdeva on 11.03.24.
//

import XCTest
@testable import ToDoShared

final class ToDoListRepositoryTests: XCTestCase {

    var sut: ToDoListRepository!
    var mockToDoListDataSource: ToDoListJSONDataSource!
    
    override func setUp() {
        mockToDoListDataSource = MockToDoListDataSource(todoListSaved: true)
        sut = ToDoListRepository(datasource: mockToDoListDataSource)
    }
    
    func testGetNodeList() {
        let nodes = sut.getNodeList()
        XCTAssertTrue(nodes?.count == 1)
    }
    
    func testSaveNodeList() {
        let nodes = sut.getNodeList()
        let status = sut.saveNodeList(nodes)
        XCTAssertTrue(status)
    }

    class MockToDoListDataSource: ToDoListJSONDataSource {
        var todoListSaved = false
        
        init(todoListSaved: Bool = false) {
            self.todoListSaved = todoListSaved
        }
        
        override func getToDoList() -> NSMutableArray! {
            let array: NSMutableArray = NSMutableArray()
            let node = TreeNode(value: "one")
            node?.identifier = "1"
            let child1 = TreeNode(value: "child1")
            child1?.identifier = "1.1"
            let child2 = TreeNode(value: "child2")
            child2?.identifier = "1.2"
            array.add([child1, child2])
            node?.children = [child1, child2]
            
            return [node]
        }
        
        override func save(toDoList todoList: NSMutableArray!) -> Bool {
            return todoListSaved
        }
    }
}
