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
    let viewModel = ToDoViewModel(toToDoListManager: ToDoListManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }

    @objc func addTapped(sender: UIBarButtonItem) {
        showTodoItemViewController()
    }
    
    func showTodoItemViewController(node: TreeNode? = nil, isSubTask: Bool = false) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: String(describing: EditToDoItemViewController.self)) { coder in
            return EditToDoItemViewController(coder: coder, viewModel: EditToDoItemViewModel(toToDoListManager: self.viewModel.toToDoListManager), selectedNode: node, isSubTask: isSubTask)
        }
        show(viewController, sender: self)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getToDoListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItemTableViewCell") as? ToDoListItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setContent(node: viewModel.getToDoListItem(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTodoItemViewController(node: viewModel.getToDoListItem(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addSubTask = UIContextualAction(style: .normal, title: "Add Subtask") { [weak self, indexPath] (action, view, completionHandler) in
          if let self = self {
              let listItem = viewModel.getToDoListItem(index: indexPath.row)
              self.showTodoItemViewController(node: listItem, isSubTask: true)
              
            completionHandler(true)
           }
           completionHandler(false)
        }
        
        let deleteSubTask = UIContextualAction(style: .destructive, title: "Delete") { [weak self, indexPath] (action, view, completionHandler) in
          if let self = self {
              let listItem = viewModel.getToDoListItem(index: indexPath.row)

            completionHandler(true) // New Line
           }
           completionHandler(false) // New Line
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteSubTask, addSubTask])
        return swipeActions
    }
}
