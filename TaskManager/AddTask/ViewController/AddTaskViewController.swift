//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 07/05/22.
//

import UIKit

final class AddTaskViewController: UIViewController {

    @IBOutlet weak var colorStackView: TaskColorStackView!
    @IBOutlet weak var deadlineTaskField: UITextField!
    @IBOutlet weak var titleTaskField: UITextField!
    @IBOutlet weak var taskTypeStackView: TaskTypeStackView!
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private let presenter: AddTaskViewPresenter
    
    init(presenter: AddTaskViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadlineTaskField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapAction))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func onTapAction() {
        view.endEditing(true)
    }
    
    @objc private func didSelectDate(_ sender: UIDatePicker) {
        deadlineTaskField.text = presenter.getFormattedDate(from: sender.date)
    }
    
    @IBAction func onTapSaveButton(_ sender: Any) {
        guard let deadline = deadlineTaskField.text, !deadline.isEmpty else {
            return
        }
        
        guard let title = titleTaskField.text, !title.isEmpty else {
            return
        }
        
        presenter.addNewTask(
            title: title,
            type: taskTypeStackView.selectedTaskType,
            color: colorStackView.selectedColor,
            deadline: datePicker.date
        )
    }
}
