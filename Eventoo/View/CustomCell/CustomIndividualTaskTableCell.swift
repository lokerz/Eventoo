//
//  DivisionTableViewCell.swift
//  Eventoo
//
//  Created by Willa on 25/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class DivisionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDescLabel: UILabel!
    @IBOutlet weak var doneMark: UIView!
    
    
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
    
    func setCell(task : Task){
        taskDescLabel.text = task.taskName
        taskTitleLabel.text = task.taskDetail
        if task.taskDone{
            doneMark.isHidden = false
        }
        
    }
    
    
    
    
}
