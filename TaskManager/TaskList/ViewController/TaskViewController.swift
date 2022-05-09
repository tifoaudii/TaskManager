//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 06/05/22.
//

import UIKit

protocol TaskViewControllerNavigationDelegate {
    func displayAddTaskView(from viewController: UIViewController, didAddNewTask: @escaping (() -> Void))
}

final class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var filterIndicatorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var failedButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleStackView: UIStackView!
    
    private var lastContentOffset: CGFloat = 0.0
    
    private let navigationDelegate: TaskViewControllerNavigationDelegate
    private let presenter: TaskViewPresenter
    
    private var tasks: [Task] = []
    
    init(presenter: TaskViewPresenter, navigationDelegate: TaskViewControllerNavigationDelegate) {
        self.presenter = presenter
        self.navigationDelegate = navigationDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Task Manager"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TaskCell", bundle: .main), forCellReuseIdentifier: TaskCell.identifier)
        fetchTasks()
    }
    
    private func fetchTasks() {
        presenter.fetchPresentableTask { tasks in
            self.tasks = tasks
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset: CGFloat = scrollView.contentOffset.y
        let percentage: CGFloat = contentOffset / 5
        titleStackView.alpha = 1 - percentage
        
        if lastContentOffset > contentOffset {
            if titleTopConstraint.constant < 0 && contentOffset < 50 {
                titleTopConstraint.constant += 10
                titleStackView.layoutIfNeeded()
            }
            
        } else {
            if titleTopConstraint.constant > -90 && contentOffset > 0 {
                titleTopConstraint.constant -= 10
                titleStackView.layoutIfNeeded()
            }
        }
        
        lastContentOffset = scrollView.contentOffset.y
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
    
    @IBAction func onTapAddTaskButton(_ sender: Any) {
        navigationDelegate.displayAddTaskView(from: self) { [weak self] in
            self?.fetchTasks()
        }
    }
    
    private func setInActive(for buttons: UIButton...) {
        buttons.forEach { $0.setTitleColor(.black, for: .normal) }
    }
    
    private func moveFilterIndicatorView(to index: Int) {
        let leadingSpace: CGFloat = filterStackView.frame.width / 4 * CGFloat(index)
        filterIndicatorLeadingConstraint.constant = leadingSpace
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
