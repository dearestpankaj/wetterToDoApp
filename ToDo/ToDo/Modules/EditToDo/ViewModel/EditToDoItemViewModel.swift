//
//  EditToDoItemViewModel.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import Foundation
import ToDoShared

class EditToDoItemViewModel {
    
    let toDoListService: ToDoListService
    
    init(toDoListService: ToDoListService) {
        self.toDoListService = toDoListService
    }
    
    func addItem(parent node: TreeNode?, text: String) {
        let childNode = TreeNode(value: text)
        toDoListService.saveNode(withParent: node, andChild: childNode)
    }
    
    func update(for node: TreeNode?, text: String) {
        toDoListService.updateTodoItem(node, andText: text)
    }
}
