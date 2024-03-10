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
    let isEditingNode: Bool!
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNode))
        button.isEnabled = false
        return button
    }()
    
    init?(coder: NSCoder, viewModel: EditToDoItemViewModel!, selectedNode: TreeNode? = nil, isEditingNode: Bool = false) {
        self.viewModel = viewModel
        self.selectedNode = selectedNode
        self.isEditingNode = isEditingNode
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false

        guard let selectedNode else {
            return
        }
        
        titleLabel.text = selectedNode.title
        if isEditingNode {
            taskTextField.text = selectedNode.title
        }
        
        guard let text = taskTextField.text else {
            return
        }
        saveButton.isEnabled = true
    }
    
    @objc func saveNode(sender: UIBarButtonItem) {
        guard let text = taskTextField.text else {
            return
        }
        if isEditingNode {
            viewModel.update(for: selectedNode, text: text)
        } else {
            viewModel.addItem(parent: selectedNode, text: text)
        }
        navigationController?.popViewController(animated: true)
    }
}
extension EditToDoItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        saveButton.isEnabled = (!string.isEmpty || range.length < (textField.text ?? "").count)
        return true
    }
}
