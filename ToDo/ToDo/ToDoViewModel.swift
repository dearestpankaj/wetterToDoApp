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
        todoList = todoListManager.todoList as! [TreeNode]
        
    }
    
    func addNode() {
        todoList.append(TreeNode(value: "10"))
    }
    
    func addSecondNode() {
        todoList.append(TreeNode(value: "20"))
        print(todoList)
        print(todoList.first?.title)
        print(todoList.first?.children)
    }
}
