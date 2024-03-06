//
//  EditToDoItemViewController.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import UIKit

class EditToDoItemViewController: UIViewController {
    
    let viewModel: EditToDoItemViewModel!
    
    init?(coder: NSCoder, viewModel: EditToDoItemViewModel!) {
        self.viewModel = viewModel
            super.init(coder: coder)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNode))
    }
    
    @objc func saveNode(sender: UIBarButtonItem) {
        
    }
}
