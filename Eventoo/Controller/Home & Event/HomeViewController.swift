//
//  HomeViewController.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 24/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class HomeViewController: UIViewController{
    

    @IBOutlet weak var eventOrganizerLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!

    @IBAction func createNewsButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UITextView!
    @IBOutlet weak var newsSlideView: UIView!
    
    @IBOutlet weak var progressCircleBar: MBCircularProgressBarView!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load Data
        DataManager.shared.loadData()
        DataManager.shared.dummyData()
        
        //Large Titles
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.title = DataManager.shared.eventArr[0].eventName
        eventOrganizerLabel.text = DataManager.shared.eventArr[0].eventLeader
        newsTitleLabel.text = DataManager.shared.newsArr[0].newsTitle
        if let newsAuthor = DataManager.shared.newsArr[0].newsWriter{
            newsAuthorLabel.text = "Created by \(newsAuthor.memberName)"
        }else{
            newsAuthorLabel.text = "Created by Anonymous"
        }
        newsContentLabel.text = DataManager.shared.newsArr[0].newsContent
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        eventDateLabel.text = dateFormatter.string(from: DataManager.shared.eventArr[0].eventDate)
        
        newsSlideView.layer.cornerRadius = 10
        newsSlideView.layer.shadowColor = UIColor.lightGray.cgColor
        newsSlideView.layer.shadowOpacity = 0.1
        newsSlideView.layer.shadowRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var progress :CGFloat = 0
        for task in DataManager.shared.taskArr{
            if task.taskDone{
                progress += 1
            }
        }
        if progress > 0{
            self.progressCircleBar.value = progress/CGFloat(DataManager.shared.taskArr.count) * 100
        }
        else{
            self.progressCircleBar.value = 0
        }
        
        progressLabel.textAlignment = .center
        if progressCircleBar.value < 100 {
            progressLabel.text = "Task on Progress"
        }
        else{
            progressLabel.text = "All Task Done"
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
