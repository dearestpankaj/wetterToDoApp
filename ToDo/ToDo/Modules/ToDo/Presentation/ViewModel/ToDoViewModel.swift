//
//  ToDoViewModel.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import Foundation
import ToDoShared

protocol ToDoViewModelProtocol {
    func getToDoList()
    func getToDoListItem(index: Int) -> TreeNode?
    func setNodeCompletion(node: TreeNode, isComplete: Bool)
    func removeNodeAtIndex(index: Int, completion: (_ indexes: [IndexPath]) -> Void)
    func moveRowAt(sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func rowsOrderAllowed(sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) -> Bool
}

class ToDoViewModel: ToDoViewModelProtocol {
    var todoList = [TreeNode]()
    let toDoListService: ToDoListService
    
    init(toDoListService: ToDoListService) {
        self.toDoListService = toDoListService
    }
    
    func getToDoList() {
        if let list = toDoListService.getFlattenedNodes() as? [TreeNode] {
            todoList = list
        }
    }
    
    func getToDoListCount() -> Int {
        todoList.count
    }
    
    func getToDoListItem(index: Int) -> TreeNode? {
        return todoList[index]
    }
    
    func setNodeCompletion(node: TreeNode, isComplete: Bool) {
        toDoListService.setNodeAndChildrenCompletion(node, isComplete)
    }
    
    func removeNodeAtIndex(index: Int, completion: (_ indexes: [IndexPath]) -> Void) {
        let node = getToDoListItem(index: index)
        if let indexes = toDoListService.remove(node) as? [Int] {
            getToDoList()
            let indexTobDeleted = indexes.sorted { $0 > $1 }.map{ IndexPath(row: $0, section: 0) }
            completion(indexTobDeleted)
        }
    }
    
    func moveRowAt(sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let sourceNode = getToDoListItem(index: sourceIndexPath.row),
              let destinationNode = getToDoListItem(index: destinationIndexPath.row) else {
            return
        }
        toDoListService.moveNodePostion(sourceNode, destinationNode)
        getToDoList()
    }
    
    //only allow reorder if it is done at same level
    func rowsOrderAllowed(sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) -> Bool {
        guard let sourceRowIdentifier = todoList[sourceIndexPath.row].identifier,
              let destinationRowIdentifier = todoList[destinationIndexPath.row].identifier else {
            return false
        }
        
        if isRootNode(identifier: sourceRowIdentifier) && isRootNode(identifier: destinationRowIdentifier) {
            return true//both root nodes
        }
        
        if sourceRowIdentifier.dropLast(2) == destinationRowIdentifier.dropLast(2) {
            return true//source and destination are at same level
        }
        return false
    }
    
    private func isRootNode(identifier: String) -> Bool {
        !identifier.contains(".")
    }
}
