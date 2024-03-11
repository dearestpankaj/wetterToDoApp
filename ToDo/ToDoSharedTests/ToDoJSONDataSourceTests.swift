//
//  ToDoJSONDataSourceTests.swift
//  ToDoSharedTests
//
//  Created by Pankaj Sachdeva on 11.03.24.
//

import XCTest
@testable import ToDoShared

final class ToDoJSONDataSourceTests: XCTestCase {
    let sut = ToDoListJSONDataSource()
    
    override func setUp() {
        
    }

    func testSaveToDoList() {
        let status = sut.save(toDoList: getNodeArrayTestData())
        XCTAssertTrue(status)
    }

    func testGetToDoList() {
        let status = sut.save(toDoList: getNodeArrayTestData())
        let array = sut.getToDoList()
        XCTAssertTrue(array?.count == 2)
    }
    
    func getNodeArrayTestData() -> NSMutableArray {
        let node1 = TreeNode(value: "one")
        node1?.identifier = "1"
        
        let node2 = TreeNode(value: "two")
        node2?.identifier = "2"
        
        let array: NSMutableArray = NSMutableArray()
        array.add(node1)
        array.add(node2)
        
        return array
    }
}
