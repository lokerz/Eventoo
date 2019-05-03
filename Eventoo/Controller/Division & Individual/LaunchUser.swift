//
//  LaunchUser.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 26/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class LaunchUser: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    let blackView = UIView()
    let tableView : UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(){
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "customUserCell", bundle: nil), forCellReuseIdentifier: "customUserCell")
    }
    

    func showUser(){
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.6)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showUserDismiss)))
            
            //blackView
            window.addSubview(blackView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //userView
            window.addSubview(tableView)
            let height :CGFloat = window.frame.height / 2
            let width :CGFloat = window.frame.width * 5 / 6
            let x : CGFloat = (window.frame.width - width)/2
            let y :CGFloat = (window.frame.height - height)/2
            tableView.frame = CGRect(x: (window.frame.width/2), y: (window.frame.height/2), width: 0, height: 0)
            tableView.layer.cornerRadius = 30
            
            //Animate
            UIView.animate(withDuration: 0.2){
                self.blackView.alpha = 1
                //self.collectionView.alpha = 1
                self.tableView.frame = CGRect(x: x, y: y, width: width, height: height)
            }
        }
    }
    
    @objc func showUserDismiss(){
        UIView.animate(withDuration: 0.2){
            self.blackView.alpha = 0
            //self.collectionView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
            self.tableView.frame = CGRect(x: (window.frame.width/2), y: (window.frame.height/2), width: 0, height: 0)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.memberArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customUserCell", for : indexPath)
        cell.textLabel?.text = DataManager.shared.memberArr[indexPath.row].memberName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DataManager.shared.currentMember = DataManager.shared.memberArr[indexPath.row]
        showUserDismiss()
    }
    
    
}
