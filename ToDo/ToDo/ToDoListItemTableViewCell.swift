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
    @IBOutlet weak var todoItemLeadingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setContent(node: TreeNode?) {
        if let node = node, let title = node.title, let number = node.number {
            var prefix = "Root "
            if number.contains("."){
                prefix = "Child "
            }
            setLeadingConstraint(title: number)
            todoItemLabel.text = "\(prefix) \(number) - \(title)"
        }
    }
    
    func setLeadingConstraint(title: String) {
        let arr = title.components(separatedBy: ".")
        todoItemLeadingConstraint.constant = CGFloat(10 * arr.count)
    }
    
    @IBAction func taskCompletionAction(_ sender: UIButton) {
        
    }
}
