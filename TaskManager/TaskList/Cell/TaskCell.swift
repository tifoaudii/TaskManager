//
//  TaskCell.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 06/05/22.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var taskTypeLabel: UILabel!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDeadlineDateLabel: UILabel!
    @IBOutlet weak var taskDeadlineTimeLabel: UILabel!
    
    static let identifier = "TaskCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTypeLabel.backgroundColor = .white
        taskTypeLabel.textColor = .black
        taskTypeLabel.layer.borderWidth = 1.5
        taskTypeLabel.layer.borderColor = UIColor.black.cgColor
    }

    func configureData(task: PresentableTask) {
        cardView.backgroundColor = task.taskColor
        taskTitleLabel.text = task.taskTitle
        taskDeadlineDateLabel.text = task.taskDeadlineDate
        taskDeadlineTimeLabel.text = task.taskDeadlineTime
        taskTypeLabel.text = task.taskType
    }
}
