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
    private var isHeaderHidden = false
    
    private let navigationDelegate: TaskViewControllerNavigationDelegate
    private let presenter: TaskViewPresenter
    
    private var tasks: [PresentableTask] = []
    
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
        fetchTasks(for: .today)
    }
    
    private func fetchTasks(for contentType: TaskContentType) {
        presenter.fetchTask(for: contentType) { [weak self] tasks in
            self?.tasks = tasks
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        
        let task = tasks[indexPath.row]
        let contentType = presenter.contentType
        cell.configureData(task: task, for: contentType)
        cell.didTapTaskButton = { [weak self] in
            task.selection()
            self?.fetchTasks(for: contentType)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y - lastContentOffset
        
        if contentOffset > 0 && scrollView.contentOffset.y > 0 {
            if titleTopConstraint.constant > -80 {
                titleTopConstraint.constant -=  contentOffset
            }
        }
        
        if contentOffset < 0 && scrollView.contentOffset.y < 0 {
            if titleTopConstraint.constant < 0 {
                if titleTopConstraint.constant - contentOffset > 0 {
                    titleTopConstraint.constant = 0
                } else {
                    titleTopConstraint.constant -= contentOffset
                }
            }
        }
        
        titleStackView.alpha = 1 - (titleTopConstraint.constant / -80)
        lastContentOffset = scrollView.contentOffset.y
    }
    
    @IBAction func onTapTodayButton(_ sender: Any) {
        todayButton.setTitleColor(.white, for: .normal)
        setInActive(for: upcomingButton, doneButton, failedButton)
        moveFilterIndicatorView(to: 0)
        presenter.updateContentType(with: .today)
        fetchTasks(for: .today)
    }
    
    @IBAction func onTapUpcomingButton(_ sender: Any) {
        upcomingButton.setTitleColor(.white, for: .normal)
        setInActive(for: todayButton, doneButton, failedButton)
        moveFilterIndicatorView(to: 1)
        presenter.updateContentType(with: .upcoming)
        fetchTasks(for: .upcoming)
    }
    
    
    @IBAction func onTapDoneButton(_ sender: Any) {
        doneButton.setTitleColor(.white, for: .normal)
        setInActive(for: upcomingButton, todayButton, failedButton)
        moveFilterIndicatorView(to: 2)
        presenter.updateContentType(with: .done)
        fetchTasks(for: .done)
    }
    
    @IBAction func onTapFailedButton(_ sender: Any) {
        failedButton.setTitleColor(.white, for: .normal)
        setInActive(for: upcomingButton, doneButton, todayButton)
        moveFilterIndicatorView(to: 3)
        presenter.updateContentType(with: .failed)
        fetchTasks(for: .failed)
    }
    
    @IBAction func onTapAddTaskButton(_ sender: Any) {
        navigationDelegate.displayAddTaskView(from: self) { [weak self] in
            self?.fetchTasks(for: .today)
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
