//
//  ToDoListItemTableViewCell.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 06.03.24.
//

import UIKit
import ToDoShared

class ToDoListItemTableViewCell: UITableViewCell {
    @IBOutlet weak var todoItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setContent(node: TreeNode?) {
        if let node = node, let title = node.title {
            todoItemLabel.text = title
        }
    }
    
    @IBAction func taskCompletionAction(_ sender: UIButton) {
        
    }
}
