//
//  CrossfitTableViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 2/27/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//
// Loni for everything
// programatic stackview https://makeapppie.com/2015/11/11/how-to-add-stack-views-programmatically-and-almost-avoid-autolayout/
// change cell color https://medium.com/@ronm333/improving-the-appearance-of-ios-tableviews-9effb7184efb
// color value https://www.ralfebert.de/ios-examples/uikit/swift-uicolor-picker/
// header color https://stackoverflow.com/questions/813068/uitableview-change-section-header-color
// take video https://www.ioscreator.com/tutorials/record-video-ios-tutorial

import UIKit
import SafariServices
class CrossfitTableViewController: UITableViewController, AddViewControllerDelegate, UINavigationControllerDelegate {
    
    func saveWorkout(workout: WOD) {
        if workout.type == "AMRAP"
        {
            workouts[0].append(workout)
        }
        else if workout.type == "For Time"
        {
            workouts[1].append(workout)
        }
        else
        {
            workouts[2].append(workout)
        }
        tableView.reloadData()
    }
 
    var workouts = [[WOD]]()
    var sections = ["AMRAP", "For Time", "RFT"]
    let userDefaults = UserDefaults.standard
    
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let encoded = try? JSONEncoder().encode(workouts){
            UserDefaults.standard.set(encoded, forKey: "workouts")
        } else {
            print("Encoding Failed")
        }
    }
    
    @IBAction func uploadButton(_ sender: UIBarButtonItem) {
        var retrievedWorkouts = [[WOD(name: " ", type: " ", length: 0, explanation: " ")]]
        if let object = UserDefaults.standard.data(forKey: "workouts") {
            if let objectDecoded = try? JSONDecoder().decode([[WOD]].self, from: object) as [[WOD]] {
                retrievedWorkouts = objectDecoded
            }
        } else {
            print("Decoding Failed")
        }
        workouts = retrievedWorkouts
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddViewController
        vc.delegate = self
    }
    
    override func viewDidLoad() {
        self.clearsSelectionOnViewWillAppear = false
        
        workouts = [[WOD(name: "Cindy", type: "AMRAP", length: 20, explanation: "5 Pull-Ups \n 10 Push-Ups \n 15 Air Squats"), WOD(name: "Open 19.1", type: "AMRAP", length: 15, explanation: "19 wall-balls (20/14 lb) \n 19 cal row")],[WOD(name: "Grace", type: "For Time", length: 10, explanation: "30 Clean-and-Jerks (135/95 lb)"),WOD(name: "Filty Fifty", type: "For Time", length: 45, explanation: "50 Box Jumps (24/20 in) \n 50 Jumping Pull-Ups \n 50 Kettlebell Swings \n 50 Walking Lunges \n 50 Knees-to-Elbows \n 50 Push Press (45/35 lb) \n 50 Back Extensions \n 50 Wall Balls (20/14 lb) \n 50 Burpees \n 50 Double-Unders"), WOD(name: "Murph", type: "For Time", length: 60, explanation: "1 mile Run \n 100 Pull-Ups \n 200 Push-Ups \n 300 Air Squats \n 1 mile Run")], [WOD(name: "Fran", type: "RFT", length: 9, explanation: "21-15-9 \n Thrusters (95/65 lb) \n Pull-Ups")]]
        tableView.register(UINib(nibName: "CrossfitTableViewCell", bundle: nil), forCellReuseIdentifier: "CrossfitCell")
        view.backgroundColor = .black
        super.viewDidLoad()
    }
    
    
    @IBAction func databasePressed(_ sender: UIBarButtonItem) {
        if let url = URL(string: "http://wodwell.com/wods/")
        {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workouts[indexPath.section][indexPath.row]
        let viewController = WodDetailViewController()
        viewController.workout = workout
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrossfitCell", for:indexPath) as! CrossfitTableViewCell
        let workout = workouts[indexPath.section][indexPath.row]
        cell.nameLabel.text = workout.name
        cell.lengthLabel.text = "\(workout.length) min"
        cell.showsReorderControl = true
        if (indexPath.row % 2 == 0) { cell.backgroundColor = UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0)}
        else {cell.backgroundColor = UIColor(red: 1, green: 0.6118, blue: 0.2275, alpha: 1.0)}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            workouts[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView,editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedWorkout = workouts[fromIndexPath.section].remove(at: fromIndexPath.row)
        workouts[to.section].insert(movedWorkout, at: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts[section].count
    }
}
