//
//  DivisionEachViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 26/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class DivisionEachViewController: UIViewController {

    @IBOutlet weak var divisionSegmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    @IBOutlet weak var divisionTaskView: UIView!
    @IBOutlet weak var divisionDetailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisionDetailView.alpha = 0
        divisionTaskView.alpha = 1
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = DataManager.shared.currentDivision?.divisionName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func divisionSegment(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 1){
            divisionDetailView.alpha = 1
            divisionTaskView.alpha = 0
            addTaskButton.isEnabled = false
        }else{
            divisionDetailView.alpha = 0
            divisionTaskView.alpha = 1
            addTaskButton.isEnabled = true
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

