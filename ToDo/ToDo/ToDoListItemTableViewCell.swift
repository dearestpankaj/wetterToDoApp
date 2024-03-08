//
//  ToDoListItemTableViewCell.swift
//  ToDo
//
//  Created by Pankaj Sachdeva on 06.03.24.
//

import UIKit
import ToDoShared

protocol ToDoListItemTableViewCellDelegate: AnyObject {
    func nodeCompletion(node: TreeNode, isComplete: Bool)
}

class ToDoListItemTableViewCell: UITableViewCell {
    @IBOutlet weak var todoItemLabel: UILabel!
    @IBOutlet weak var todoItemLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var completionButton: UIButton!
    var myNode: TreeNode!
    
    weak var delegate: ToDoListItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        completionButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        completionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
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
            completionButton.isSelected = node.isCompleted
            myNode = node
        }
    }
    
    func setLeadingConstraint(title: String) {
        let arr = title.components(separatedBy: ".")
        todoItemLeadingConstraint.constant = CGFloat(10 * arr.count)
    }
    
    @IBAction func taskCompletionAction(_ sender: UIButton) {
        completionButton.isSelected = !myNode.isCompleted
        delegate?.nodeCompletion(node: myNode, isComplete: !myNode.isCompleted)
    }
}
