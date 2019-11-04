//
//  PersonalBestsTableViewController.swift
//  Crossfit
//
//  Created by Ana Klabjan on 4/26/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import UIKit

class PersonalBestsTableViewController: UITableViewController {
    
    var lifts = [lift(name: "Front Squat", best: 0), lift(name: "Front Squat", best: 0), lift(name: "Back Squat", best: 0), lift(name: "Clean", best: 0), lift(name: "Bench Press", best: 0), lift(name: "Push Press", best: 0)]
    let userDefaults = UserDefaults.standard
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Workout", message: nil, preferredStyle: .alert)
        alert.addTextField() {
            (textField) in
            textField.placeholder = "Lift Name"
        }
        alert.addTextField() {
            (textField) in
            textField.placeholder = "Current PR"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let firstTextField = alert.textFields![0] as UITextField
            let secondTextField = alert.textFields![1] as UITextField
            let newLift = lift(name: firstTextField.text!, best: Int(secondTextField.text!)!)
            self.lifts.append(newLift)
            self.tableView.reloadData()
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let encoded = try? JSONEncoder().encode(lifts){
            UserDefaults.standard.set(encoded, forKey: "lifts")
        } else {
            print("Encoding Failed")
        }
    }
    
    @IBAction func uploadButton(_ sender: UIBarButtonItem) {
        var retrievedBest = [lift(name: "", best: 0)]
        if let object = UserDefaults.standard.data(forKey: "lifts") {
            if let objectDecoded = try? JSONDecoder().decode([lift].self, from: object) as [lift] {
                retrievedBest = objectDecoded
            }
        } else {
            print("Decoding Failed")
        }
        lifts = retrievedBest
        tableView.reloadData()
    }
   
    
    override func viewDidLoad() {
        self.clearsSelectionOnViewWillAppear = false
        tableView.register(UINib(nibName: "CrossfitTableViewCell", bundle: nil), forCellReuseIdentifier: "CrossfitCell")
        view.backgroundColor = .black
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let vc = storyboard?.instantiateViewController(withIdentifier: "percentages") as! PRViewController
        vc.exersize = lifts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrossfitCell", for:indexPath) as! CrossfitTableViewCell
        let lift = lifts[indexPath.row]
        cell.nameLabel.text = lift.name
        cell.lengthLabel.text = "\(lift.best) lbs"
        cell.showsReorderControl = true
        if (indexPath.row % 2 == 0) { cell.backgroundColor = UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0)}
        else {cell.backgroundColor = UIColor(red: 1, green: 0.6118, blue: 0.2275, alpha: 1.0)}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lifts.remove(at: indexPath.row)
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
        let movedLift = lifts.remove(at: fromIndexPath.row)
        lifts.insert(movedLift, at: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lifts.count
    }
}
