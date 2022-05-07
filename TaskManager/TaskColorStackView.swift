//
//  TaskColorStackView.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 07/05/22.
//

import UIKit

final class TaskColorStackView: UIStackView {
    
    private(set) var selectedColor: TaskColorType = .green
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        TaskColorType.allCases.enumerated().forEach { (index, colorType) in
            let button: UIButton = UIButton(type: .system)
            index == 0 ? setActiveState(for: button) : setInActiveState(for: button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            button.tintColor = colorType.color
            button.tag = index
            button.layer.cornerRadius = 12
            button.layer.borderWidth = 1.5
            button.addTarget(self, action: #selector(didTapColorButton(_:)), for: .touchUpInside)
            addArrangedSubview(button)
        }
    }
    
    @objc private func didTapColorButton(_ sender: UIButton) {
        guard sender.tag < TaskColorType.allCases.count else {
            fatalError("Index out of ranged!")
        }
        
        let color = TaskColorType.allCases[sender.tag]
        selectedColor = color
        
        arrangedSubviews.enumerated().forEach { (index, subview) in
            index == sender.tag ? setActiveState(for: subview) : setInActiveState(for: subview)
        }
    }
    
    private func setActiveState(for view: UIView) {
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setInActiveState(for view: UIView) {
        view.layer.borderColor = UIColor.clear.cgColor
    }
}
