//
//  ViewController.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

import UIKit
import ToDoShared

class ToDoListViewController: UIViewController {

    let viewModel = ToDoViewModel(toToDoListManager: ToDoListManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func addTapped(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: String(describing: EditToDoItemViewController.self)) { coder in
            return EditToDoItemViewController(coder: coder, viewModel: EditToDoItemViewModel(toToDoListManager: self.viewModel.toToDoListManager))
        }
        show(viewController, sender: self)
    }
}

