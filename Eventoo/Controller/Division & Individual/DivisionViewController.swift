//
//  AllTaskViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 24/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class DivisionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    

    @IBOutlet weak var divisionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        divisionTable.delegate = self
        divisionTable.dataSource = self
        divisionTable.register(UINib(nibName: "CustomAllDivisionTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomAllDivisionTableViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        divisionTable.reloadData()
    }
    
    @IBAction func addDivision(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Division", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        alert.addTextField(configurationHandler: { textField1 in
            textField1.placeholder = "Division Name"
        })
        alert.addTextField(configurationHandler: { textField2 in
            textField2.placeholder = "Division Leader"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            var divisionExist = false
            if let name = alert.textFields?.first?.text {
                if let leader = alert.textFields?[1].text{
                    let tempDivision = Division (divisionName : name, divisionLeader : leader)
                    for division in DataManager.shared.divisionArr{
                        if division == tempDivision{
                            divisionExist = true
                            break
                        }
                    }
                    if !divisionExist {
                        DataManager.shared.divisionArr.append(tempDivision)
                        DataManager.shared.saveData()
                    }
                    self.divisionTable.reloadData()
                }
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.divisionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomAllDivisionTableViewCell", for : indexPath) as! AllTaskTableViewCell
        //cell
        cell.setCell(division: DataManager.shared.divisionArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DataManager.shared.currentDivision = DataManager.shared.divisionArr[indexPath.row]
        performSegue(withIdentifier: "divisionTaskSegue", sender: self)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
        DataManager.shared.divisionArr.remove(at: indexPath.row)
            tableView.reloadData()
        }

        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            tableView.reloadData()
            DataManager.shared.currentDivision = DataManager.shared.divisionArr[indexPath.row]
            self.performSegue(withIdentifier: "editDivisionSegue", sender: self)
            tableView.reloadData()
        }

        edit.backgroundColor = UIColor.lightGray
        
        

        return [delete, edit]
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
