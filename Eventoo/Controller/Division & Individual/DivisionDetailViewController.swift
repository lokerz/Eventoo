//
//  DivisionDetailViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 26/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class DivisionDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var divName: UITextField!
    @IBOutlet weak var divLeader: UITextField!
    
    @IBAction func deleteDivision(_ sender: UIButton) {
        for i in 0...DataManager.shared.divisionArr.count - 1{
            if DataManager.shared.divisionArr[i] == DataManager.shared.currentDivision{
                DataManager.shared.divisionArr.remove(at: i)
                break
            }
        }
        DataManager.shared.saveData()
        
 navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var addMemberField: UITextField!
    
    @IBAction func addMemberButton(_ sender: UIButton) {
        if addMemberField.text != ""{
        if let addMemberText = addMemberField.text{
            let tempMember = Member(memberID: DataManager.shared.memberArr.count, memberDivision: DataManager.shared.currentDivision!, memberName: addMemberText)
            DataManager.shared.memberArr.append(tempMember)
            addMemberField.text = ""
            let subviews = memberListView.subviews
            for view in subviews{
                view.removeFromSuperview()
            }
        }
        }
        DataManager.shared.saveData()
        memberListView.reloadData()
    }
    
    @IBOutlet weak var memberListView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Division Name
        divName.text = DataManager.shared.currentDivision?.divisionName
        
        //Division Leader
        divLeader.text = DataManager.shared.currentDivision?.divisionLeader
        
        divName.addTarget(self, action: #selector(editNameEnd), for: .editingDidEnd)
        divName.addTarget(self, action: #selector(editNameCurrent), for: .editingChanged)
        divLeader.addTarget(self, action: #selector(editLeaderEnd), for: .editingDidEnd)
        
        //Division Member
        memberListView.delegate = self
        memberListView.dataSource = self
        memberListView.register(UINib(nibName: "customMemberViewCell", bundle: nil), forCellWithReuseIdentifier: "customMemberViewCell")
        print(DataManager.shared.divisionArr)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memberListView.reloadData()
    }
    
    @objc func editNameEnd(){
        for i in 0...DataManager.shared.divisionArr.count - 1{
            if DataManager.shared.divisionArr[i] == DataManager.shared.currentDivision{
            DataManager.shared.currentDivision?.divisionName = divName.text!
            DataManager.shared.divisionArr[i].divisionName = divName.text!
                
                DataManager.shared.saveData()
            }
        }
    }
    @objc func editNameCurrent(){
        parent?.navigationItem.title = divName.text
    }
    
    @objc func editLeaderEnd(){
        for i in 0...DataManager.shared.divisionArr.count - 1{
            if DataManager.shared.divisionArr[i] == DataManager.shared.currentDivision{
                DataManager.shared.currentDivision?.divisionLeader = divLeader.text!
                DataManager.shared.divisionArr[i].divisionLeader = divLeader.text!
                DataManager.shared.saveData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for member in DataManager.shared.memberArr{
            if member.memberDivision == DataManager.shared.currentDivision{
                count += 1
            }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberListView.dequeueReusableCell(withReuseIdentifier: "customMemberViewCell", for: indexPath) as! customMemberViewCell
        var currentTaskRow = 0
        if let currentDivision = DataManager.shared.currentDivision{
            for i in 0...DataManager.shared.memberArr.count - 1{
                if (DataManager.shared.memberArr[i].memberDivision == currentDivision){
                    currentTaskRow = i
                    break
                }
            }
        }
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 15
        cell.setInitial(initial: String(DataManager.shared.memberArr[indexPath.row + currentTaskRow].memberName.prefix(1)).uppercased())
        
        return cell
    }
    
}
