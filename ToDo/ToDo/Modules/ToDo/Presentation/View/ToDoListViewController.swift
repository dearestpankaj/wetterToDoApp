//
//  ViewController.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import UIKit
import ToDoShared

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    let viewModel = ToDoViewModel(toDoListService: ToDoListService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reorder", style: .done, target: self, action: #selector(reorderTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getToDoList()
        todoTableView.reloadData()
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        showTodoItemViewController()
    }
    
    @objc func reorderTapped(sender: UIBarButtonItem) {
        todoTableView.setEditing(!todoTableView.isEditing, animated: true)
    }
    
    func showTodoItemViewController(node: TreeNode? = nil, isEditingNode: Bool = false) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: String(describing: EditToDoItemViewController.self)) { coder in
            return EditToDoItemViewController(coder: coder, viewModel: EditToDoItemViewModel(toDoListService: self.viewModel.toDoListService), selectedNode: node, isEditingNode: isEditingNode)
        }
        show(viewController, sender: self)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getToDoListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListItemTableViewCell.reuseIdentifier) as? ToDoListItemTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.setContent(node: viewModel.getToDoListItem(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTodoItemViewController(node: viewModel.getToDoListItem(index: indexPath.row), isEditingNode: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeActions = UISwipeActionsConfiguration(actions: [
            deleteContextualAction(forRowAt: indexPath),
            addSubtaskContextualAction(forRowAt: indexPath),
        ]
        )
        return swipeActions
    }
    
    private func deleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            self.viewModel.removeNodeAtIndex(index: indexPath.row) { indexes in
                self.todoTableView.deleteRows(at: indexes, with: .automatic)
                completion(true)
            }
        }
    }
    
    private func addSubtaskContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Add Subtask") { [weak self] (_, _, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            let listItem = viewModel.getToDoListItem(index: indexPath.row)
            self.showTodoItemViewController(node: listItem)
            completion(true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveRowAt(sourceIndexPath: sourceIndexPath, to: destinationIndexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if !viewModel.rowsOrderAllowed(sourceIndexPath: sourceIndexPath, to: proposedDestinationIndexPath){
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
}
extension ToDoListViewController: ToDoListItemTableViewCellDelegate {
    func nodeCompletion(node: TreeNode, isComplete: Bool) {
        viewModel.setNodeCompletion(node: node, isComplete: isComplete)
        todoTableView.reloadData()
    }
}
