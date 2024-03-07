//
//  ToDoViewModel.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import Foundation
import ToDoShared

class ToDoViewModel {
    var todoList = [TreeNode]()
    
    let toToDoListManager: ToDoListManager
    
    init(toToDoListManager: ToDoListManager) {
        self.toToDoListManager = toToDoListManager
    }
    
    func getToDoList() {
        let todoListManager = ToDoListManager()
        if let list = todoListManager.todoList as? [TreeNode] {
            todoList = list
        }
    }
    
    func getToDoListCount() -> Int {
        print(toToDoListManager.todoList)
//        for nodeMain in toToDoListManager.todoList {
//            if let nodeMain = nodeMain as? TreeNode {
//                
//            }
//        }
        print(countItemsInList(list: toToDoListManager.todoList as! [TreeNode]))
        return toToDoListManager.todoList.count
    }
    
    func countItemsInList(list: [TreeNode]) -> Int {
        var count = 0

        for item in list {
            // Count the current item
            count += 1

            // Recursively count the subitems
            if let children = item.children as? [TreeNode] {
                count += countItemsInList(list: children)
            }
            
        }
        return count
    }
    
    func getToDoListItem(index: Int) -> TreeNode? {
        toToDoListManager.todoList[index] as? TreeNode
    }
}
