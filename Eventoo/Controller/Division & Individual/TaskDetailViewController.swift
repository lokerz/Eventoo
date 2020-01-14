//
//  TaskDetailViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 03/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class TaskDetailViewController : UIViewController {
 
    @IBOutlet weak var taskDivisionLabel: UILabel!
    @IBOutlet weak var taskDeadlineLabel: UILabel!
    @IBOutlet weak var taskDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = DataManager.shared.currentTask?.taskName
        taskDivisionLabel.text = "Division : \( DataManager.shared.currentTask!.taskDivision.divisionName)"
        taskDetailLabel.text = DataManager.shared.currentTask?.taskDetail
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        taskDeadlineLabel.text = dateFormatter.string(from: DataManager.shared.currentTask!.taskDeadline)
        
    }
    
    
    @IBAction func taskDoneButton(_ sender: UIButton) {
        for i in 0...DataManager.shared.taskArr.count - 1{
            if DataManager.shared.taskArr[i] == DataManager.shared.currentTask{
                DataManager.shared.taskArr[i].taskDone = true
            }
        }
        DataManager.shared.saveData()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func taskRemoveButton(_ sender: UIButton) {
        for i in 0...DataManager.shared.taskArr.count - 1{
            if DataManager.shared.taskArr[i] == DataManager.shared.currentTask{
                DataManager.shared.taskArr.remove(at: i)
                break
            }
        }
        DataManager.shared.saveData()
        navigationController?.popViewController(animated: true)

    }
    
}
