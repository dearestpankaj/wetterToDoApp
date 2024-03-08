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
    
    func addItem(text: String) {
        let itemCount = toDoListManager.todoList.count
        let node = TreeNode(value: text, String(itemCount + 1))
        toDoListManager.addChild(node)
    }
}
