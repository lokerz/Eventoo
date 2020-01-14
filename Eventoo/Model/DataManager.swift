//
//  DataManager.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 25/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    private override init(){
        currentEvent = nil
        currentTask = nil
        currentMember = nil
        currentDivision = nil
    }
    
    
    var memberArr : [Member] = []
    var eventArr : [Event] = []
    var divisionArr : [Division] = []
    var taskArr : [Task] = []
    var newsArr : [News] = []
    
    var currentEvent : Event?
    
    var currentDivision : Division?
    var currentMember : Member?
    var currentTask : Task?
    var removeDivision : Bool = false
    
    func saveData(){
        let database = UserDefaults.standard
        database.set(try! PropertyListEncoder().encode(eventArr), forKey: "eventDB" )
        database.set(try! PropertyListEncoder().encode(memberArr), forKey: "memberDB")
        database.set(try! PropertyListEncoder().encode(divisionArr), forKey: "divisionDB")
        database.set(try! PropertyListEncoder().encode(taskArr), forKey: "taskDB")
        database.set(try! PropertyListEncoder().encode(newsArr), forKey: "newsDB")
        database.synchronize()
        
    }
    
    func loadData(){
        let database = UserDefaults.standard
        
        if let data = database.value(forKey: "eventDB") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<Event>.self, from: data)
            eventArr = temp!
        }
        if let data = database.value(forKey: "memberDB") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<Member>.self, from: data)
            memberArr = temp!
        }
        if let data = database.value(forKey: "divisionDB") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<Division>.self, from: data)
            divisionArr = temp!
        }
        if let data = database.value(forKey: "taskDB") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<Task>.self, from: data)
            taskArr = temp!
        }
        if let data = database.value(forKey: "newsDB") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<News>.self, from: data)
            newsArr = temp!
        }
    }
    
    func dummyData(){
        
        let dummyEvent = Event(eventName : "Technopreneur", eventLeader: "Himpunan Mahasiswa Manajemen dan Ekonomi",eventDate: Date.init(timeIntervalSinceNow: 10368000) ,eventProgress: 0.0)
        DataManager.shared.eventArr.append(dummyEvent)

        let dummyNews  = News(newsEvent: dummyEvent, newsTitle: "Sponsorship", newsWriter: nil, newsContent: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        DataManager.shared.newsArr.append(dummyNews)
        
    }
}

    struct Member : Codable, Equatable{
        var memberDivision : Division
        var memberName : String
        static func == (member1 : Member, member2 : Member) -> Bool{
            return (member1.memberName.lowercased() == member2.memberName.lowercased())
        }
    }

    struct News : Codable, Equatable{
        var newsEvent : Event
        var newsTitle : String
        var newsWriter : Member?
        var newsContent : String
        static func == (news1 : News, news2 : News) -> Bool{
            return (news1.newsTitle.lowercased() == news2.newsTitle.lowercased())
        }
    }

    struct Event : Codable, Equatable{
        var eventName : String
        var eventLeader : String
        var eventDate : Date
        var eventProgress : Double
        static func == (event1 : Event, event2 : Event) -> Bool{
            return (event1.eventName.lowercased() == event2.eventName.lowercased() && event1.eventLeader == event2.eventLeader)
        }
    }
    
    struct Division : Codable, Equatable {
        var divisionName : String
        var divisionLeader : String
        static func == (division1 :Division, division2 : Division) ->Bool{
            return(division1.divisionName.lowercased() == division2.divisionName.lowercased())
        }
    }

    struct Task : Codable, Equatable{
        var taskName : String
        var taskMember : [Member]
        var taskDivision : Division
        var taskDeadline : Date
        var taskDetail : String
        var taskDone : Bool = false
        static func == (task1 : Task, task2: Task) -> Bool {
            return (task1.taskName.lowercased() == task2.taskName.lowercased() && task1.taskDivision == task2.taskDivision)
        }
    }
    
    //Functions :

