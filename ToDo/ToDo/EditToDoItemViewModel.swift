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
        let node = TreeNode(value: text)
        toToDoListManager.addChild(node)
    }
}
