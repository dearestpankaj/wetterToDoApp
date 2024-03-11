//
//  ToDoViewModelTests.swift
//  ToDoTests
//
//  Created by Pankaj Sachdeva on 11.03.24.
//

import XCTest
@testable import ToDoShared
@testable import ToDo

final class ToDoViewModelTests: XCTestCase {
    var mockToDoListService: ToDoListService!
    var sut: ToDoViewModel!
    
    override func setUp() {
        mockToDoListService = MockToDoListService()
        sut = ToDoViewModel(toDoListService: mockToDoListService)
    }

    func testToDoList() {
        sut.getToDoList()
        XCTAssertTrue(sut.todoList.count == 2)
    }
    
    func testGetToDoListCount() {
        sut.getToDoList()
        XCTAssertTrue(sut.getToDoListCount() == 2)
    }
    
    func testGetToDoListItem() {
        sut.getToDoList()
        XCTAssertNotNil(sut.getToDoListItem(index: 0))
    }
    
    func testRemoveNodeAtIndex() {
        sut.getToDoList()
        sut.removeNodeAtIndex(index: 0) { indexes in
            XCTAssert(indexes.count == 1)
        }
    }
    
    func testRowsReorderAllowed() {
        sut.getToDoList()
        let status = sut.rowsReorderAllowed(sourceIndexPath: IndexPath(row: 0, section: 0), to: IndexPath(row: 1, section: 0))
        XCTAssertTrue(status)
    }
    
    class MockToDoListService: ToDoListService {
        override func getFlattenedNodes() -> NSMutableArray! {
            let node1 = TreeNode(value: "one")
            node1?.identifier = "1"
            
            let node2 = TreeNode(value: "two")
            node2?.identifier = "2"
            
            return [node1, node2]
        }
        
        override func getParentTreeNode(_ node: TreeNode!) -> TreeNode! {
            let node1 = TreeNode(value: "one")
            node1?.identifier = "1"
            return node1
        }
        
        override func remove(_ treeNode: TreeNode!) -> NSMutableArray! {
            return [0]
        }
    }
}
