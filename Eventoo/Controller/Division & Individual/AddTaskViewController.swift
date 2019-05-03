//
//  AddTaskViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 24/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   

    var tempMemberArr : [Member] = []
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskMemberField: UITextField!
    @IBOutlet weak var taskDeadline: UIDatePicker!
    @IBOutlet weak var taskDetailField: UITextField!
    @IBOutlet weak var taskMemberTable: UITableView!
    
    @IBAction func addTaskButton(_ sender: UIButton) {
        let task = Task(taskID: DataManager.shared.taskArr.count, taskName: taskNameField.text!.capitalized, taskMember: tempMemberArr, taskDivision: DataManager.shared.currentDivision!, taskDeadline: taskDeadline.date, taskDetail: taskDetailField.text!, taskDone: false)
        
        for tempMember in tempMemberArr{
            var memberExist = false
            for member in DataManager.shared.memberArr{
                if(tempMember == member){
                    memberExist = true
                }
            }
            if !memberExist{
                DataManager.shared.memberArr.append(tempMember)
            }
        }
        if(taskNameField != nil && tempMemberArr.count != 0){
            DataManager.shared.taskArr.append(task)
            DataManager.shared.saveData()

            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func addMemberButton(_ sender: UIButton) {
        var memberExist = 99
        if let memberName = taskMemberField.text{
            if DataManager.shared.memberArr.count > 0{
                for i in 0...DataManager.shared.memberArr.count - 1{
                    if DataManager.shared.memberArr[i].memberName == memberName {
                        memberExist = i
                    }
                }
            }
            if memberExist != 99 {
                tempMemberArr.append(DataManager.shared.memberArr[memberExist])
            }else{
                let member = Member(memberID: DataManager.shared.memberArr.count, memberDivision: DataManager.shared.currentDivision!, memberName: memberName)
                tempMemberArr.append(member)
            }
            taskMemberField.text = ""
            taskMemberTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDetailField.borderStyle = UITextField.BorderStyle.roundedRect
        taskDeadline.datePickerMode = UIDatePicker.Mode.date
      
        taskMemberTable.delegate = self
        taskMemberTable.dataSource = self
        taskMemberTable.register(UINib(nibName: "customUserCell", bundle: nil), forCellReuseIdentifier: "customUserCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMemberArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customUserCell", for: indexPath) as! customUserCell
        cell.textLabel?.text = tempMemberArr[indexPath.row].memberName.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tempMemberArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
