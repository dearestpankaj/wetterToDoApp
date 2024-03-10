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
        return todoList[index]
    }
    
    func setNodeCompletion(node: TreeNode, isComplete: Bool) {
        toDoListService.setNodeAndChildrenCompletion(node, isComplete)
    }
    
    func removeNodeAtIndex(index: Int, completion: (_ indexes: [IndexPath]) -> Void) {
        let node = getToDoListItem(index: index)
        if let indexes = toDoListService.remove(node) as? [Int] {
            getToDoList()
            let indexTobDeleted = indexes.map{ IndexPath(row: $0, section: 0) }
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
        guard let sourceRowIdentifier = todoList[sourceIndexPath.row].identifier else {
            return false
        }
        guard let destinationRowIdentifier = todoList[destinationIndexPath.row].identifier else {
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
    
    func isRootNode(identifier: String) -> Bool {
        !identifier.contains(".")
    }
}
