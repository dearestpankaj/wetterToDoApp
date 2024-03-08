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
    @IBOutlet weak var titleLabel: UILabel!
    
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
        titleLabel.text = selectedNode.title
        // FIXME: something is not right here
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
                let childrenCount = String((selectedNode?.children.count ?? 0) + 1)
                if let nodeNumber = selectedNode?.identifier {
                    let node  = TreeNode(value: text, "\(nodeNumber).\(childrenCount)")
                    selectedNode?.children.add(node)
                }
                
            } else {
                selectedNode?.title = text
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
