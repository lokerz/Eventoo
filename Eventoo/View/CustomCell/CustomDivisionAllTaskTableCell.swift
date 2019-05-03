//
//  CustomDivisionAllTask.swift
//  Eventoo
//
//  Created by Willa on 29/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class CustomDivisionAllTask: UITableViewCell {
    
    
    @IBOutlet weak var taskTitleNameLabel: UILabel!
    
    
    @IBOutlet weak var taskDescLabel: UILabel!
    
    @IBOutlet weak var doneMark: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var initialsPersonLabel: UILabel!
    
    func setCell(task : Task){
        taskTitleNameLabel.text = task.taskName
        taskDescLabel.text = task.taskDetail
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateLabel.text = dateFormatter.string(from: task.taskDeadline)
        if task.taskDone{
            doneMark.isHidden = false
        }
     
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        doneMark.isHidden = true
        doneMark.layer.cornerRadius = 5
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
