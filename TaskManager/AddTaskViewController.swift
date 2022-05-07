//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 07/05/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var greenColorButton: UIButton!
    @IBOutlet weak var blueColorButton: UIButton!
    @IBOutlet weak var tealColorButton: UIButton!
    @IBOutlet weak var pinkColorButton: UIButton!
    @IBOutlet weak var grayColorButton: UIButton!
    @IBOutlet weak var deadlineTaskField: UITextField!
    @IBOutlet weak var titleTaskField: UITextField!
    @IBOutlet weak var basicButton: UIButton!
    @IBOutlet weak var urgentButton: UIButton!
    @IBOutlet weak var importantButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenColorButton.layer.borderColor = UIColor.black.cgColor
        greenColorButton.layer.borderWidth = 1.0
        greenColorButton.layer.cornerRadius = greenColorButton.frame.height / 2
        
        urgentButton.layer.borderWidth = 1.0
        urgentButton.layer.borderColor = UIColor.black.cgColor
        
        importantButton.layer.borderWidth = 1.0
        importantButton.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func onTapSaveButton(_ sender: Any) {
    }
}
