//
//  EditToDoItemViewModel.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import Foundation
import ToDoShared

class EditToDoItemViewModel {
    
    let toDoListManager: ToDoListManager
    
    init(toDoListManager: ToDoListManager) {
        self.toDoListManager = toDoListManager
    }
    
    func addItem(parent node: TreeNode?, text: String) {
        let childNode = TreeNode(value: text)
        toDoListManager.saveNode(withParent: node, andChild: childNode)
    }
    
    func update(for node: TreeNode?, text: String) {
        toDoListManager.updateTodoItem(node, andText: text)
    }
}
