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
        if let list = toToDoListManager.todoList as? [TreeNode] {
            todoList = list
        }
    }
    
    func getToDoListCount() -> Int {
        if let list = toToDoListManager.todoList as? [TreeNode] {
            return countItemsInList(list: list)
        }
        return 0
    }
    
    func countItemsInList(list: [TreeNode]) -> Int {
        var count = 0

        for item in list {
            count += 1
            if let children = item.children as? [TreeNode] {
                count += countItemsInList(list: children)
            }
            
        }
        return count
    }
    
    func getToDoListItem(index: Int) -> TreeNode? {
        toToDoListManager.getFlattenedNodes()[index] as? TreeNode
    }
    
    func setNodeCompletion(node: TreeNode, isComplete: Bool) {
        toToDoListManager.setNodeAndChildrenCompletion(node, isComplete)
    }
}
