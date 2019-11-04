//
//  TodayViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 4/25/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//  Ana Klabjan
//  Crossfit App
//  allows user to see dailey workout, past workouts, personal list of favorite workouts and personal records.
// Lonnie
// https://firebase.google.com/docs/firestore/query-data/get-data getting data from firebase
// https://stackoverflow.com/questions/53469351/error-call-firebaseapp-configure-before-using-firestore configurating firebase
// https://stackoverflow.com/questions/50233281/how-to-get-an-array-from-firestore how to get array from firebase
// https://medium.com/@lukasthinks/appdelegate-is-not-the-first-code-to-run-54c1535db443 storyboard runs before AppDelegate
// https://stackoverflow.com/questions/42524651/convert-nsdate-to-string-in-ios-swift convert date to string
// https://stackoverflow.com/questions/51116381/convert-firebase-firestore-timestamp-to-date-swift how to retrieve date

import UIKit
import Firebase

var pastWorkouts = [WOD]()
var database: Firestore!

class TodayViewController: UIViewController {
    
    @IBOutlet var timeCap: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var wod: UILabel!
    @IBOutlet var name: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       FirebaseApp.configure()
        database = Firestore.firestore()
        
        database.collection("workout").order(by: "date", descending: true).getDocuments() { (querySnapshot, err) in
        //database.collection("workout").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let date = document.data()["date"] as! Timestamp
                    let timeCap = document.data()["timeCap"] as! Int
                    print(timeCap)
                    let type = document.data()["type"] as! String
                    print(type)
                    let name = document.documentID
                    print(name)
                    let array = document["components"] as? Array ?? [""]
                    var description = ""
                    for line in array
                    {
                        description += "\(line) \n"
                    }
                    let newDate = Date(timeIntervalSince1970: TimeInterval(date.seconds))
                    print(description)
                    
                    pastWorkouts.append(WOD(name: name, type: type, length: timeCap, explanation: description, date: newDate.toString(dateFormat: "MM-dd")))
                }
            }
            if pastWorkouts[0].type == "AMRAP"
            {
                self.timeCap.text = "\(pastWorkouts[0].length) minutes"
            }
            else
            {
                self.timeCap.text = "\(pastWorkouts[0].length) minute cap"
            }
            self.type.text = pastWorkouts[0].type
            self.wod.text = pastWorkouts[0].explanation
            self.name.text = pastWorkouts[0].name
        }
    }
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
