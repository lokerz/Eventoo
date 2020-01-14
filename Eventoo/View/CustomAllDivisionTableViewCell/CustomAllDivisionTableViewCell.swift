//
//  AllTaskTableViewCell.swift
//  Eventoo
//
//  Created by Willa on 25/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class AllTaskTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var divisionNameLabel: UILabel!
    @IBOutlet weak var leadPersonLabel: UILabel!
    @IBOutlet weak var collectionInitialPerson: UICollectionView!
    @IBOutlet weak var taskCompleteLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var cellView: UIView!
    
    var currentDivision : Division?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        collectionInitialPerson.dataSource = self
        collectionInitialPerson.delegate = self
        collectionInitialPerson.register(UINib(nibName: "customMemberViewCell", bundle: nil), forCellWithReuseIdentifier: "customMemberViewCell")
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        // Initialization code
    }
    
    
    func setCell(division : Division){
        var taskDone = 0
        var taskTotal = 0
        currentDivision = division
        divisionNameLabel.text = division.divisionName
        leadPersonLabel.text = division.divisionLeader
        for task in DataManager.shared.taskArr{
            if(task.taskDivision == division){
                taskTotal += 1
                if(task.taskDone){
                    taskDone += 1
                }
            }
        }
        taskCompleteLabel.text = "\(taskDone)/\(taskTotal)"
        if taskTotal > 0{
            progressBar.progress = Float(taskDone)/Float(taskTotal)
        }else{
            progressBar.progress = 0
        }
        collectionInitialPerson.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for member in DataManager.shared.memberArr{
            if member.memberDivision == currentDivision{
                count += 1
            }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionInitialPerson.dequeueReusableCell(withReuseIdentifier: "customMemberViewCell", for: indexPath) as! customMemberViewCell
        var currentTaskRow = 0
        for i in 0...DataManager.shared.memberArr.count - 1{
            if (DataManager.shared.memberArr[i].memberDivision == currentDivision){
                currentTaskRow = i
                break
            }
        }
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 7
         cell.setInitial(initial: String(DataManager.shared.memberArr[indexPath.row + currentTaskRow].memberName.prefix(1)).uppercased())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25)
    }

}
