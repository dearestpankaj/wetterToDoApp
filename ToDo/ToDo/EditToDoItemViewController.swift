//
//  EditToDoItemViewController.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import UIKit
import ToDoShared

class EditToDoItemViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    let viewModel: EditToDoItemViewModel!
    let selectedNode: TreeNode?
    let isSubTask: Bool!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNode))
        
        
        guard let selectedNode else {
            return
        }
        
        if !isSubTask {
            taskTextField.text = selectedNode.title
        }
    }
    
    init?(coder: NSCoder, viewModel: EditToDoItemViewModel!, selectedNode: TreeNode? = nil, isSubTask: Bool = false) {
        self.viewModel = viewModel
        self.selectedNode = selectedNode
        self.isSubTask = isSubTask
        
        super.init(coder: coder)
    }
    
    @objc func saveNode(sender: UIBarButtonItem) {
        guard let text = taskTextField.text else {
            return
        }
        if selectedNode == nil {
            viewModel.addItem(text: text)
        } else {
            if isSubTask {
                let node  = TreeNode()
                node.title = text
                selectedNode?.children.add(node)
            } else {
                selectedNode?.title = text
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
