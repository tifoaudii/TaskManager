//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 06/05/22.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var filterIndicatorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var failedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Task Manager"
    }
    
    @IBAction func onTapTodayButton(_ sender: Any) {
        todayButton.setTitleColor(.white, for: .normal)
        setInActive(for: upcomingButton, doneButton, failedButton)
        moveFilterIndicatorView(to: 0)
    }
    
    
    @IBAction func onTapUpcomingButton(_ sender: Any) {
        upcomingButton.setTitleColor(.white, for: .normal)
        setInActive(for: todayButton, doneButton, failedButton)
        moveFilterIndicatorView(to: 1)
    }
    
    
    @IBAction func onTapDoneButton(_ sender: Any) {
        doneButton.setTitleColor(.white, for: .normal)
        setInActive(for: upcomingButton, todayButton, failedButton)
        moveFilterIndicatorView(to: 2)
    }
    
    @IBAction func onTapFailedButton(_ sender: Any) {
        failedButton.setTitleColor(.white, for: .normal)
        setInActive(for: upcomingButton, doneButton, todayButton)
        moveFilterIndicatorView(to: 3)
    }
    
    private func setInActive(for buttons: UIButton...) {
        buttons.forEach { $0.setTitleColor(.black, for: .normal) }
    }
    
    private func moveFilterIndicatorView(to index: Int) {
        let leadingSpace = filterStackView.frame.width / 4 * CGFloat(index)
        
        UIView.animate(withDuration: 0.25) {
            self.filterIndicatorLeadingConstraint.constant = leadingSpace
            self.view.layoutIfNeeded()
        }
    }
}
