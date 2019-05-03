//
//  DivisionTaskViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 24/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class DivisionTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var taskIndexArr : [Int] = []
   
    
    @IBOutlet weak var individualDivisionTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
         individualDivisionTable.register(UINib(nibName: "CustomDivisionAllTaskTableCell", bundle: nil), forCellReuseIdentifier: "CustomDivisionAllTaskTableCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskIndexArr = []
        individualDivisionTable.delegate = self
        individualDivisionTable.dataSource = self
        
        if DataManager.shared.taskArr.count > 0{
            for i in 0...DataManager.shared.taskArr.count - 1{
                if(DataManager.shared.taskArr[i].taskDivision == DataManager.shared.currentDivision!){
                    taskIndexArr.append(i)
                }
            }
        }
            individualDivisionTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let currentDivision = DataManager.shared.currentDivision{
            for task in DataManager.shared.taskArr{
                if (task.taskDivision == currentDivision){
                    count += 1
                }
            }
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDivisionAllTaskTableCell", for : indexPath) as! CustomDivisionAllTask
        cell.setCell(task: DataManager.shared.taskArr[taskIndexArr[indexPath.row]])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DataManager.shared.currentTask = DataManager.shared.taskArr[taskIndexArr[indexPath.row]]
        performSegue(withIdentifier: "DivisionTaskDetailSegue", sender: self)
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        for i in 0...DataManager.shared.taskArr.count - 1{
            if DataManager.shared.taskArr[i] == DataManager.shared.currentTask{
                DataManager.shared.taskArr[i].taskDone = true
            }
        }
    }
    @IBAction func removeButtonAction(_ sender: UIButton) {
        for i in 0...DataManager.shared.taskArr.count - 1{
        if DataManager.shared.taskArr[i] == DataManager.shared.currentTask{
            DataManager.shared.taskArr.remove(at: i)
            break
            }
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


/*
 for division in divisionArr{
 for task in taskArr{
    if task.division = division
        print(task)
 
 }
 }
 
 
 
 */
