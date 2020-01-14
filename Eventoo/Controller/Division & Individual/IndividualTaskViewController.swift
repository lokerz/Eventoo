//
//  IndividualTaskViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 24/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class IndividualTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var individualTaskTable: UITableView!
    
    var showMember : Member?
    var count = 0
    var individualTaskIndexArr: [Int] = []
    let launchSystem = LaunchUser()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        individualTaskTable.delegate = self
        individualTaskTable.dataSource = self
        individualTaskTable.register(UINib(nibName: "CustomIndividualTaskTableCell", bundle: nil), forCellReuseIdentifier: "CustomIndividualTaskTableCell")
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "load"), object: nil)
        loadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomIndividualTaskTableCell", for : indexPath) as! DivisionTableViewCell
        cell.setCell(task: DataManager.shared.taskArr[individualTaskIndexArr[indexPath.row]])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DataManager.shared.currentTask = DataManager.shared.taskArr[individualTaskIndexArr[indexPath.row]]
        performSegue(withIdentifier: "IndividualTaskDetailSegue", sender: self)
    }
    
    @IBAction func userButton(_ sender: UIBarButtonItem) {
        launchSystem.showUser()
        print(DataManager.shared.memberArr)
    }
    
    @objc func loadData(){
        individualTaskIndexArr = []
        count = 0
        
        if let showMember = DataManager.shared.currentMember {
        
            if(showMember.memberName.last == "s"){
                navigationItem.title = "\(showMember.memberName)' Task"
            }else{
            navigationItem.title = "\(showMember.memberName)'s Task"
            }
            if DataManager.shared.taskArr.count > 0 {
                for i in 0...DataManager.shared.taskArr.count - 1{
                    for member in DataManager.shared.taskArr[i].taskMember{
                        if (member == showMember){
                        count += 1
                        individualTaskIndexArr.append(i)
                        }
                    }
                }
            }
            individualTaskTable.reloadData()
        }
    }
}
