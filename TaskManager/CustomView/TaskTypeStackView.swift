//
//  TaskTypeStackView.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import UIKit

enum TaskType: String, CaseIterable {
    case basic = "Basic"
    case urgent = "Urgent"
    case important = "Important"
}

final class TaskTypeStackView: UIStackView {
    
    private(set) var selectedTaskType: TaskType = .basic
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        TaskType.allCases.enumerated().forEach { (index, taskType) in
            let button: UIButton = UIButton(type: .system)
            index == 0 ? setActiveStyle(for: button) : setInActiveStyle(for: button)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 16
            button.tag = index
            button.setTitle(taskType.rawValue, for: .normal)
            button.addTarget(self, action: #selector(didTapTaskButton(_:)), for: .touchUpInside)
            addArrangedSubview(button)
        }
    }
    
    @objc private func didTapTaskButton(_ sender: UIButton) {
        guard sender.tag < TaskType.allCases.count else {
            fatalError("Index out of range!")
        }
        
        let task = TaskType.allCases[sender.tag]
        selectedTaskType = task
        
        arrangedSubviews.enumerated().forEach { (index, subview) in
            guard let button = subview as? UIButton else {
                return
            }
            
            index == sender.tag ? setActiveStyle(for: button) : setInActiveStyle(for: button)
        }
    }
    
    private func setActiveStyle(for button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
    }
    
    private func setInActiveStyle(for button: UIButton) {
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
    }
}
