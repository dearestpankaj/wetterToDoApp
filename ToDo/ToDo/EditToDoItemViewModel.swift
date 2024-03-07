//
//  EditToDoItemViewModel.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import Foundation
import ToDoShared

class EditToDoItemViewModel {
    
    let toToDoListManager: ToDoListManager
    
    init(toToDoListManager: ToDoListManager) {
        self.toToDoListManager = toToDoListManager
    }
    
    func addItem(text: String) {
        let itemCount = toToDoListManager.todoList.count
        let node = TreeNode(value: text, String(itemCount + 1))
        toToDoListManager.addChild(node)
    }
}
